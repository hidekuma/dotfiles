local dap_ok, dap = pcall(require, "dap")
local dap_ui_ok, ui = pcall(require, "dapui")

if not (dap_ok and dap_ui_ok) then
	require("notify")("nvim-dap or dap-ui not installed!", "warning") -- nvim-notify is a separate plugin, I recommend it too!
	return
end

dap.set_log_level("INFO") -- Helps when configuring DAP, see logs with :DapShowLog

--[[ Commands ]]
vim.fn.sign_define("DapBreakpoint", { text = "🐞" })
-- Start debugging session
vim.keymap.set("n", "<localleader>ds", function()
	dap.continue()
	ui.toggle({})
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
end)

-- Set breakpoints, get variable values, step into/out of functions, etc.
vim.keymap.set("n", "<localleader>dl", require("dap.ui.widgets").hover)
vim.keymap.set("n", "<localleader>dc", dap.continue)
vim.keymap.set("n", "<localleader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<localleader>dn", dap.step_over)
vim.keymap.set("n", "<localleader>di", dap.step_into)
vim.keymap.set("n", "<localleader>do", dap.step_out)
vim.keymap.set("n", "<localleader>dC", function()
	dap.clear_breakpoints()
	require("notify")("Breakpoints cleared", "warn")
end)

-- Close debugger and clear breakpoints
vim.keymap.set("n", "<localleader>de", function()
	dap.clear_breakpoints()
	ui.toggle({})
	dap.terminate()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
	require("notify")("Debugger session ended", "warn")
end)

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

dap.adapters = {
	-- Python adapter
	python = {
		type = "executable",
		command = vim.fn.stdpath("data") .. "/mason/bin/debugpy-adapter",
	},
	-- Kotlin adapter
	kotlin = {
		type = "executable",
		command = vim.fn.stdpath("data") .. "/mason/bin/kotlin-debug-adapter",
	},
}
--[[ dap.adapters.python = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "/mason/bin/debugpy",
		args = {
			"--listen",
			"localhost:${port}",
		},
	},
} ]]
dap.configurations = {
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

ui.setup({
	icons = {
		expanded = "▾",
		collapsed = "▸",
		current_frame = "-",
	},
	mappings = {
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	expand_lines = vim.fn.has("nvim-0.7"),
	layouts = {
		--[[ { ]]
		--[[ 	elements = { ]]
		--[[ 		"scopes", ]]
		--[[ 	}, ]]
		--[[ 	size = 0.2, ]]
		--[[ 	position = "right", ]]
		--[[ }, ]]
		{
			elements = {
				"repl",
				--[[ "breakpoints", ]]
			},
			size = 0.2,
			position = "bottom",
		},
	},
	controls = {
		element = "repl",
		enabled = true,
	},
	floating = {
		max_height = nil,
		max_width = nil,
		border = "single",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil,
	},
})
