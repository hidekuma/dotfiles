local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
	return
end

local mason_lsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lsp_ok then
	return
end

local lsp_config_api = vim.lsp and vim.lsp.config
local lsp_enable = vim.lsp and vim.lsp.enable
if not lsp_config_api or not lsp_enable then
	return
end

local SERVERS = {
	"marksman",
	"jsonls",
	"dockerls",
	"eslint",
	-- "gradle_ls",
	-- "groovyls",
	"cssls",
	"lua_ls",
	"pyright",
	"pylsp",
	-- "jdtls", java 11 버전 지원을 위해 수동으로 설치진행 MasonInstall jdtls@0.57
	"sqlls",
	"yamlls",
	-- "kotlin_language_server",
	"ts_ls"
}


mason.setup()
mason_lspconfig.setup({
	ensure_installed = SERVERS,
	automatic_enable = false,
})

-- local venv_path = os.getenv('VIRTUAL_ENV')
-- local py_path = nil
-- decide which python executable to use for mypy
-- if venv_path ~= nil then
-- 	py_path = venv_path .. "/bin/python3"
-- else
-- 	py_path = vim.g.python3_host_prog
-- end

vim.api.nvim_exec(
	[[
	let g:loaded_python_provider = 0
	let g:python3_host_prog='~/.virtualenvs/neovim3.12/bin/python'
]], true)

local handlers = require("user.lsp.handlers")
if not handlers then
	return
end

local function configure(server)
	local opts = {
		on_attach = handlers.on_attach,
		capabilities = handlers.capabilities,
		flags = {
			debounce_text_changes = 200,
		},
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end

	local ok, err = pcall(lsp_config_api, server, opts)
	if not ok then
		vim.notify(
			string.format("Failed to configure %s: %s", server, err),
			vim.log.levels.ERROR
		)
		return
	end

	local enabled, enable_err = pcall(lsp_enable, server)
	if not enabled then
		vim.notify(
			string.format("Failed to enable %s: %s", server, enable_err),
			vim.log.levels.ERROR
		)
	end
end

for _, server in ipairs(SERVERS) do
	configure(server)
end
