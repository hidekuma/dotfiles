local status_ok, snacks = pcall(require, "snacks")
if not status_ok then
	return
end

snacks.setup({
	notifier = {
		timeout = 3000,
		style = "compact",
	},
	dashboard = {
		wo = {
			winhighlight = "BadWhitespace:Normal",
		},
		preset = {
			header = table.concat({
				"╦ ╦╦╔╦╗╔═╗╦╔═╦ ╦╔╦╗╔═╗",
				"╠═╣║ ║║║╣ ╠╩╗║ ║║║║╠═╣",
				"╩ ╩╩═╩╝╚═╝╩ ╩╚═╝╩ ╩╩ ╩",
			}, "\n"),
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
				{ icon = " ", key = "g", desc = "Changed Files", action = ":Telescope git_status" },
				{ icon = " ", key = "e", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "p", desc = "Projects", action = ":Telescope projects" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
				{ icon = " ", key = "t", desc = "Find Text", action = ":Telescope live_grep" },
				{ icon = " ", key = "c", desc = "Configuration", action = ":e ~/.config/nvim/init.lua" },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
		},
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
			{ section = "recent_files", limit = 5, padding = 1 },
			{ section = "startup" },
		},
	},
})

-- Replace vim.notify with snacks notifier
vim.notify = snacks.notifier.notify

-- vim-bad-whitespace uses 2match (not matchadd), must clear explicitly
vim.api.nvim_create_autocmd({ "VimEnter", "BufWinEnter" }, {
	callback = function()
		vim.defer_fn(function()
			if vim.bo.filetype == "snacks_dashboard" then
				vim.cmd("match none")
				vim.cmd("2match none")
				vim.cmd("3match none")
			end
		end, 50)
	end,
})
