local keymap = vim.api.nvim_set_keymap
local opts = { silent = true, }

vim.api.nvim_set_var("translator_target_lang", "ko")

keymap("n", "<Leader>t", "<Plug>Translate", opts)
keymap("v", "<Leader>t", "<Plug>TranslateV", opts)

-- " Display translation in a window
keymap("n", "<Leader>w", "<Plug>TranslateW", opts)
keymap("v", "<Leader>w", "<Plug>TranslateWV", opts)

-- " Replace the text with translation
-- keymap("n", "<Leader>r", "<Plug>TranslateR", opts)
-- keymap("v", "<Leader>r", "<Plug>TranslateRV", opts)

-- " Translate the text in clipboard
keymap("n", "<Leader>x", "<Plug>TranslateX", opts)
