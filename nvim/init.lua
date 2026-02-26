require("user.compat")

-- plugins
require("user.plugins")

-- basic options
require("user.options")
require("user.keymaps")
require("user.autocommands")

-- snacks (dashboard, notifier)
require("user.snacks")

-- lsp and auto complete
require("user.cmp")
require("user.lsp")

-- formatter and linter
require("user.conform")
require("user.lint")

-- diagnostics
require("user.trouble")

-- finder
require("user.telescope")
require("user.fzf")

-- editing utils
require("user.autopairs")
require("user.flash")
require("user.indentline")
require("user.vim-translator")
require("user.vim-argwrap")

-- git, project
require("user.gitsigns")
require("user.nvim-tree")
require("user.project")
require("user.vim-tmux-navigator")

-- style
require("user.treesitter")
require("user.lualine")
require("user.colorscheme")

-- commands
require("user.whichkey")

-- else
require("user.toggleterm")
