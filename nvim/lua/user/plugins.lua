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
	"rcarriga/nvim-notify",

	-- Window
	"camspiers/lens.vim",
	{ "akinsho/bufferline.nvim", tag = "v3.*", dependencies = { "nvim-tree/nvim-web-devicons" } },

	-- Movement
	"Lokaltog/vim-easymotion",
	"tmux-plugins/vim-tmux-focus-events",

	-- Navigation
	"christoomey/vim-tmux-navigator",

	-- Editing utilities
	"godlygeek/tabular",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	"tpope/vim-eunuch",
	"terryma/vim-multiple-cursors",
	"FooSoft/vim-argwrap",
	"terryma/vim-expand-region",
	"bitc/vim-bad-whitespace",
	"winston0410/cmd-parser.nvim",
	"winston0410/range-highlight.nvim",
	"windwp/nvim-autopairs",
	"numToStr/Comment.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",

	-- Finder
	{ "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
	"airblade/vim-rooter",
	"moll/vim-bbye",
	"nvim-lualine/lualine.nvim",
	"akinsho/toggleterm.nvim",
	"ahmedkhalf/project.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"goolord/alpha-nvim",
	"folke/which-key.nvim",

	-- Colorschemes
	"EdenEast/nightfox.nvim",
	"folke/tokyonight.nvim",

	-- Syntax / Indenting
	"hashivim/vim-terraform",
	"Vimjas/vim-python-pep8-indent",
	"sheerun/vim-polyglot",

	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	-- Buffer
	"luukvbaal/stabilize.nvim",

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

	-- Telescope
	{ "nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies = { "nvim-lua/plenary.nvim" } },

	-- Git
	{ "sindrets/diffview.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	"airblade/vim-gitgutter",
	"tpope/vim-fugitive",
	"lewis6991/gitsigns.nvim",
})
