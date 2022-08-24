local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- Plugin manager
	use("wbthomason/packer.nvim") -- Have packer manage itself

	-- My plugins here

	-- Files & Search
	-- use("Shougo/context_filetype.vim")
	-- Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
	use("junegunn/fzf")
	use("junegunn/fzf.vim")

	-- Translators
	use("voldikss/vim-translator")

	-- Styling
	use("ap/vim-css-color") -- color preview
	use("sunjon/shade.nvim")
	use("tmux-plugins/vim-tmux-focus-events") --  with vim-diminactive (tmux)
	use("itchyny/vim-cursorword") -- display cursor position
	use("rcarriga/nvim-notify")
	use({ "kyazdani42/nvim-web-devicons", opt = true })
	--[[ use({ ]]
	-- XXX
	--[[ 	"glepnir/lspsaga.nvim", ]]
	--[[ 	branch = "main", ]]
	--[[ 	config = function() ]]
	--[[ 		local saga = require("lspsaga") ]]
	--[[]]
	--[[ 		saga.init_lsp_saga({ ]]
	--[[ 			-- your configuration ]]
	--[[ 		}) ]]
	--[[ 	end, ]]
	--[[ }) ]]

	-- Window
	use("camspiers/lens.vim") -- vim pane resizing
	use({ "SmiteshP/nvim-navic" }) -- XXX
	use({ "akinsho/bufferline.nvim", tag = "v2.*" })

	-- Movement
	use("Lokaltog/vim-easymotion")
	use("christoomey/vim-tmux-navigator")

	-- Editing utilities
	use("godlygeek/tabular")
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("tpope/vim-eunuch")
	use("terryma/vim-multiple-cursors")
	-- " Plug 'mattn/emmet-vim'
	use("FooSoft/vim-argwrap")
	use("terryma/vim-expand-region")
	use("bitc/vim-bad-whitespace")
	use("winston0410/cmd-parser.nvim")
	use("winston0410/range-highlight.nvim")
	use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "numToStr/Comment.nvim" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })

	-- Finder
	use({ "kyazdani42/nvim-tree.lua" })
	use("airblade/vim-rooter")

	use({ "moll/vim-bbye" })
	use({ "nvim-lualine/lualine.nvim" })
	-- use({ "akinsho/toggleterm.nvim" })
	use({ "ahmedkhalf/project.nvim" })
	use({ "lewis6991/impatient.nvim" })
	use({ "lukas-reineke/indent-blankline.nvim" })
	use({ "goolord/alpha-nvim" })
	use("folke/which-key.nvim")

	-- Colorschemes
	use("lunarvim/darkplus.nvim")
	use({ "folke/tokyonight.nvim" })
	use("cocopon/iceberg.vim")

	-- Syntax / Indenting
	use({ "plasticboy/vim-markdown" })
	-- Plug 'evanleck/vim-svelte', {'branch': 'main'}
	use({ "hashivim/vim-terraform" })
	use({ "Vimjas/vim-python-pep8-indent" })
	use({ "sheerun/vim-polyglot" })

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- Buffer
	use({ "luukvbaal/stabilize.nvim" })

	-- Cmp plugins
	use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "hrsh7th/cmp-cmdline" })

	-- Snippets
	use({ "L3MON4D3/LuaSnip" }) --snippet engine
	use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
	use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

	-- LSP
	use({ "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" })

	-- Format and Linter
	use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } }) -- for formatters and linters

	-- Telescope
	use("nvim-telescope/telescope.nvim")

	-- Git
	use("airblade/vim-gitgutter")
	use("tpope/vim-fugitive")
	use("lewis6991/gitsigns.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
