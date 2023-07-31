local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- keymap("n", "<A-h>", "<C-w>h", opts)
-- keymap("n", "<A-j>", "<C-w>j", opts)
-- keymap("n", "<A-k>", "<C-w>k", opts)
-- keymap("n", "<A-l>", "<C-w>l", opts)

-- Resize with arrows
-- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Close window
keymap("t", "<C-c>", "<C-\\><C-n><C-w>c", term_opts)
keymap("n", "<C-c>", "<C-w>c", opts)

-- Else
keymap("n", "<leader>r", ":!python %<CR>", opts)
keymap("n", "<Tab>", ":tabNext<CR>", opts)
keymap("n", "<S-Tab>", ":tabPrev<CR>", opts)
keymap("n", "sh", ":split<Return><C-w>w", opts)
keymap("n", "sv", ":vsplit<Return><C-w>w", opts)
keymap("n", "tn", ":tabnew<Return>", opts)

-- window resize
keymap("n", "<C-w><left>", " <C-w><", opts)
keymap("n", "<C-w><right>", " <C-w>>", opts)
keymap("n", "<C-w><up>", " <C-w>+", opts)
keymap("n", "<C-w><down>", " <C-w>-", opts)

-- set paste
-- TODO
-- keymap("n", ",p", ":set paste<CR>", opts)
-- keymap("n", ",P", ":set nopaste<CR>", opts)

-- cp file path
keymap("n", "cp", ":let @+ = expand('%')<cr>", opts)
-- keymap("n", "cP", ":let @+ = expand('%p')<cr>", opts)

keymap("t", "<C-c>", ":let @+ = expand('%p')<cr>", opts)
