-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
		}, true, {})
		return
	end
end
vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
require("lazy").setup({
	-- Files & Search
	"junegunn/fzf",
	"junegunn/fzf.vim",

	-- Translators
	"voldikss/vim-translator",

	-- Styling
	"ap/vim-css-color",
	"itchyny/vim-cursorword",

	-- Snacks (dashboard, notifier, and more)
	"folke/snacks.nvim",

	-- Window
	"camspiers/lens.vim",
	{ "akinsho/bufferline.nvim", tag = "v3.*", dependencies = { "nvim-tree/nvim-web-devicons" } },

	-- Movement
	"folke/flash.nvim",
	"tmux-plugins/vim-tmux-focus-events",

	-- Navigation
	"christoomey/vim-tmux-navigator",

	-- Editing utilities
	"godlygeek/tabular",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	"tpope/vim-eunuch",
	"FooSoft/vim-argwrap",
	"terryma/vim-expand-region",
	"windwp/nvim-autopairs",

	-- Finder
	{ "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
	"airblade/vim-rooter",
	"moll/vim-bbye",
	"nvim-lualine/lualine.nvim",
	"akinsho/toggleterm.nvim",
	"ahmedkhalf/project.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"folke/which-key.nvim",

	-- Colorschemes
	"EdenEast/nightfox.nvim",
	"folke/tokyonight.nvim",

	-- Syntax / Indenting
	"hashivim/vim-terraform",

	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	-- Cmp plugins
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-cmdline",

	-- Snippets
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"rafamadriz/friendly-snippets",

	-- LSP
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",

	-- Formatter & Linter
	"stevearc/conform.nvim",
	"mfussenegger/nvim-lint",

	-- Diagnostics UI
	"folke/trouble.nvim",

	-- Telescope
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

	-- Git
	{ "sindrets/diffview.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	"tpope/vim-fugitive",
	"lewis6991/gitsigns.nvim",
})
