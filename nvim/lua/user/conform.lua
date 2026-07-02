local status_ok, conform = pcall(require, "conform")
if not status_ok then
	return
end

conform.setup({
	formatters_by_ft = {
		python = function(bufnr)
			if conform.get_formatter_info("ruff_format", bufnr).available then
				return { "ruff_format" }
			else
				return { "isort", "black" }
			end
		end,
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd", "prettier", stop_after_first = true },
		yaml = { "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },
		terraform = { "terraform_fmt" },
		kotlin = { "ktlint" },
		lua = { "stylua" },
		sh = { "shfmt" },
		["_"] = { "trim_whitespace" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = function(bufnr)
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end

		local bufname = vim.api.nvim_buf_get_name(bufnr)
		if bufname == "" then
			return
		end

		-- skip projects that opt out via a marker file
		local disable_markers = { ".nvim-disable-format", ".disable-format", ".noformat" }
		local found = vim.fs.find(disable_markers, {
			path = vim.fs.dirname(bufname),
			upward = true,
			stop = vim.uv.os_homedir(),
		})
		if not vim.tbl_isempty(found) then
			return
		end

		return {
			timeout_ms = 500,
			lsp_format = "fallback",
		}
	end,
})
