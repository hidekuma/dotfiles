local lspconfig = require("lspconfig")
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/completion
-- local completion = null_ls.builtins.completion
local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion
local utils = require("null-ls.utils")

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

null_ls.setup({
	debug = false,
	sources = {
		-- python
		formatting.black,
		formatting.isort,
		-- NOTE
		-- install mypy plugins if you want like bottom.
		--[[ /Users/joseph/.local/share/nvim/mason/packages/mypy/venv/bin/python -m pip install mypy ]]
		--[[ diagnostics.mypy.with({
			extra_args = {},
			runtime_condition = function(params)
				return utils.path.exists(params.bufname)
			end,
		}), ]]
		diagnostics.djlint,

		-- lua
		formatting.stylua,
		-- kotlin
		-- so slow..
		--[[ formatting.ktlint, ]]
		diagnostics.ktlint.with({
			method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
		}),
		-- json
		formatting.jq,
		-- javascript
		--[[ formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }), ]]
		--[[ diagnostics.eslint_d, ]]
		-- markdown
		formatting.markdownlint,
		-- git
		--[[ code_actions.gitsigns, ]]
	},
	root_dir = lspconfig.util.root_pattern(".null-ls-root", "Makefile", ".git", "pyproject.toml"),
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
