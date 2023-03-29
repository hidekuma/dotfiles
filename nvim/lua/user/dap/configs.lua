local func_python = function()
	local cwd = vim.fn.getcwd()
	if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
		return cwd .. "/venv/bin/python"
	elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
		return cwd .. "/.venv/bin/python"
	elseif vim.fn.executable(os.getenv("VIRTUAL_ENV") .. "/bin/python") == 1 then
		return os.getenv("VIRTUAL_ENV") .. "/bin/python"
	else
		return "/usr/bin/python"
	end
end

require("dap").configurations = {
	-- Python configurations
	python = {
		{
			type = "python",
			name = "Launch Python File",
			request = "launch",
			program = "${file}", -- This configuration will launch the current file if used.
			pythonPath = func_python,
		},
		{
			type = "python",
			name = "Project(Django): runserver",
			request = "launch",
			program = vim.fn.getcwd() .. "/manage.py",
			args = {
				"runserver",
				"9898",
				"--noreload",
			},
			pythonPath = func_python,
		},
		{
			type = "python",
			name = "Project(FastAPI): server.main:app",
			request = "launch",
			module = "uvicorn",
			args = {
				"server.main:app",
				--[[ "--reload", ]]
				"--port",
				"9898",
			},
			pythonPath = func_python,
			--[[ autoReload = {
				enable = true,
			}, ]]
		},
	},
	-- Kotlin configurations
	kotlin = {
		{
			type = "kotlin",
			name = "Project(Kotlin): runserver",
			request = "launch",
			module = vim.fn.getcwd() .. "/gradlew",
			args = {
				"bootRun",
			},
		},
	},
}

-- mason-nvim-dap setup
require("mason-nvim-dap").setup({
	ensure_installed = { "python", "kotlin", "javadbg" },
})
