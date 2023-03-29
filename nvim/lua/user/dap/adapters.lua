require("dap").adapters = {
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
