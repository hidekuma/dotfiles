local keymap = vim.api.nvim_set_keymap
local opts = { silent = true, }

keymap("n", "gm", "<Plug>(git-messenger)", opts)
