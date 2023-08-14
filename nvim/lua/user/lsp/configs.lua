local status_ok, lsp_installer = pcall(require, "mason")
if not status_ok then
	return
end

local lspconfig = require("lspconfig")

local servers = {
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
	"jdtls",
	"sqlls",
	"yamlls",
	"kotlin_language_server",
	"tsserver",
}
require("mason-lspconfig").setup({
	--[[ ensure_installed = servers, ]]
	automatic_installaion = true,
})

lsp_installer.setup({
	--[[ ensure_installed = servers, ]]
	--[[ automatic_installaion = true ]]
})

-- local venv_path = os.getenv('VIRTUAL_ENV')
-- local py_path = nil
-- -- decide which python executable to use for mypy
-- if venv_path ~= nil then
-- 	py_path = venv_path .. "/bin/python3"
-- else
-- 	py_path = vim.g.python3_host_prog
-- end

for _, server in pairs(servers) do
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
	if server == "pylsp" then
		opts['filetypes'] = { "python" }
		opts['settings'] = {
			-- configurationSources = { "flake8" },
			formatCommand = { "isort" },
			pylsp = {
				plugins = {
					-- formatter options
					black = { enabled = true },
					-- autopep8 = { enabled = false },
					-- yapf = { enabled = false },
					-- linter options
					-- pylint = { enabled = false, executable = "pylint" },
					-- ruff = { enabled = false },
					-- pyflakes = { enabled = false },
					-- pycodestyle = { enabled = false },
					-- type checker
					-- pylsp_mypy = {
					--   enabled = true,
					--   overrides = { "--python-executable", py_path, true },
					--   report_progress = true,
					--   live_mode = false
					-- },
					-- auto-completion options
					-- jedi_completion = { fuzzy = true },
					-- import sorting
					isort = { enabled = true }
				}
			}
		}
	end
	lspconfig[server].setup(opts)
end
