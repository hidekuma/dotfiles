local keymap = vim.api.nvim_set_keymap
local opts = {}
vim.g.EasyMotion_leader_key = ","
keymap("", ",l", "<Plug>(easymotion-lineforward)", opts)
keymap("", ",j", "<Plug>(easymotion-j)", opts)
keymap("", ",k", "<Plug>(easymotion-k)", opts)
keymap("", ",h", "<Plug>(easymotion-linebackward)", opts)
vim.g.EasyMotion_startofline = 0
vim.g.EasyMotion_smartcase = 1
vim.g.EasyMotion_use_smartsign_us = 0
