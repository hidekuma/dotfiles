-- plugins
require("user.plugins")

-- basic options
require("user.options")
require("user.keymaps")
require("user.autocommands")

-- lsp and auto complete
require("user.cmp")
require("user.lsp")

-- finder
require("user.telescope")
require("user.fzf")

-- editing utils
require("user.autopairs")
require("user.comment")
require("user.indentline")
require("user.vim-translator")
require("user.range-hightlight")
require("user.vim-easymotion")
require("user.stabilize")
require("user.vim-argwrap")

-- git, project
require("user.gitsigns")
require("user.vim-rooter")

-- navigator
require("user.nvim-tree")
require("user.project")
require("user.alpha")
require("user.vim-tmux-navigator")

-- style
require("user.treesitter")
require("user.lualine")
require("user.colorscheme")

-- commands
require("user.whichkey")

-- else
-- require "user.toggleterm"
require("user.impatient")
