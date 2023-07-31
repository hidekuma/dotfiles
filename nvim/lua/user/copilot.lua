vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.api.nvim_set_keymap("i", "<C-e>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-H>", "copilot#Previous()", { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-L>", "copilot#Next()", { silent = true, expr = true })
