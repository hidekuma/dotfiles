local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = { "python", "javascript", "typescript", "tsx", "dockerfile", "terraform", "bash", "markdown", "htmldjango", "html" },
	-- ensure_installed = {""},            -- one of "all" or a list of languages
	-- ignore_install = { "php", "phpdoc" }, -- List of parsers to ignore installing
	highlight = {
		enable = true,                     -- false will disable the whole extension
		disable = { "css", "po", "min.js" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css" } },
})
