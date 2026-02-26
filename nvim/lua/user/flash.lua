local status_ok, flash = pcall(require, "flash")
if not status_ok then
	return
end

flash.setup({
	labels = "asdfghjklqwertyuiopzxcvbnm",
	search = { mode = "fuzzy" },
	jump = { nohlsearch = true },
	label = { rainbow = { enabled = true } },
})

-- Keymaps matching previous easymotion pattern (,leader)
vim.keymap.set({ "n", "x", "o" }, "s", function() flash.jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function() flash.treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function() flash.remote() end, { desc = "Remote Flash" })
