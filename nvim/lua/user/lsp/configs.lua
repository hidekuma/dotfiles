local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local SERVERS = {
	"marksman",
	"jsonls",
	"dockerls",
	"eslint",
	"gradle_ls",
	"groovyls",
	"cssls",
	"lua_ls",
	"pyright",
	"pylsp",
	-- "jdtls", java 11 버전 지원을 위해 수동으로 설치진행 MasonInstall jdtls@0.57
	"sqlls",
	"yamlls",
	"kotlin_language_server",
	"tsserver",
}


mason.setup()
require("mason-lspconfig").setup({
	ensure_installed = SERVERS,
	automatic_installaion = {
		exclude = "jdtls"
	},
})

local lspconfig = require("lspconfig")

-- local venv_path = os.getenv('VIRTUAL_ENV')
-- local py_path = nil
-- -- decide which python executable to use for mypy
-- if venv_path ~= nil then
-- 	py_path = venv_path .. "/bin/python3"
-- else
-- 	py_path = vim.g.python3_host_prog
-- end

for _, server in pairs(SERVERS) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
		flags = {
			debounce_text_changes = 200,
		},
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end
