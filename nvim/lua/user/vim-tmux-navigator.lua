local keymap = vim.api.nvim_set_keymap
local opts = { silent = true, }

vim.api.nvim_set_var("tmux_navigator_no_mappings", 1)

keymap("n", "<A-h>", ":TmuxNavigateLeft<cr>", opts)
keymap("n", "<A-j>", ":TmuxNavigateDown<cr>", opts)
keymap("n", "<A-k>", ":TmuxNavigateUp<cr>", opts)
keymap("n", "<A-l>", ":TmuxNavigateRight<cr>", opts)
