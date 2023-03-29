require("dapui").setup({
	icons = {
		expanded = "▾",
		collapsed = "▸",
		current_frame = "-",
	},
	mappings = {
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	expand_lines = vim.fn.has("nvim-0.7"),
	layouts = {
		--[[ { ]]
		--[[ 	elements = { ]]
		--[[ 		"scopes", ]]
		--[[ 	}, ]]
		--[[ 	size = 0.2, ]]
		--[[ 	position = "right", ]]
		--[[ }, ]]
		{
			elements = {
				"repl",
				--[[ "breakpoints", ]]
			},
			size = 0.2,
			position = "bottom",
		},
	},
	controls = {
		element = "repl",
		enabled = true,
	},
	floating = {
		max_height = nil,
		max_width = nil,
		border = "single",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil,
	},
})
