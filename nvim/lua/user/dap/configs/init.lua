require("dap").configurations = {
	python = require("user.dap.configs.python"),
	kotlin = require("user.dap.configs.kotlin"),
}

require("mason-nvim-dap").setup({
	ensure_installed = { "python", "kotlin", "javadbg" },
})
