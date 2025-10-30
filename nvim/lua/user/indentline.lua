local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
	return
end

vim.wo.colorcolumn = "99999"

ibl.setup({
	indent = {
		char = "▏",
	},
	scope = {
		enabled = true,
		show_start = false,
		show_end = false,
	},
	exclude = {
		buftypes = { "terminal", "nofile" },
		filetypes = {
			"help",
			"startify",
			"dashboard",
			"packer",
			"neogitstatus",
			"NvimTree",
			"Trouble",
		},
	},
})
