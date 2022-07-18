local keymap = vim.api.nvim_set_keymap
local opts = { silent = false }
vim.g.EasyMotion_leader_key = ","
keymap("n", ",l", "<Plug>(easymotion-lineforward)", opts)
keymap("n", ",j", "<Plug>(easymotion-j)", opts)
keymap("n", ",k", "<Plug>(easymotion-k)", opts)
keymap("n", ",h", "<Plug>(easymotion-linebackward)", opts)
vim.g.EasyMotion_startofline = 0
vim.g.EasyMotion_smartcase = 1
vim.g.EasyMotion_use_smartsign_us = 0
