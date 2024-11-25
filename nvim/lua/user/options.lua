local options = {
	termguicolors = true,
	history = 50, -- How many lines of history to remember
	confirm = true, -- Ask for confirmation in some situations (:q)
	ignorecase = true, -- ignore case in search patterns
	smartcase = true, -- smart case
	modeline = true, -- we allow modelines in textfiles to set vim settings
	hidden = true, -- allows to change buffer without saving
	mouse = "a", -- enable mouse in all modes

	backup = false, -- creates a backup file
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

	-- formatopions = "tcrqn",
	autoindent = true, -- keep indent on next line and make BS work with indenting
	smartindent = true, -- make indenting smarter again
	wrap = true, -- display lines as one long line
	smarttab = true, -- Make Tab work fine with spaces
	showmatch = true, -- show matching brackets
	matchtime = 5, -- tenths of a second to blink matching brackets
	hlsearch = true, -- highlight all matches on previous search pattern
	incsearch = true, -- do highlight as you type you search phrase
	title = true,
	conceallevel = 0, -- so that `` is visible in markdown files
	ruler = true, -- Always show current positions along the bottom
	cmdheight = 2, -- more space in the neovim command line for displaying messages
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	lazyredraw = true, -- do not redraw while running macros (much faster)
	report = 0, -- always report how many lines where changed
	laststatus = 2, -- always show the status line
	scrolloff = 8, -- is one of my fav
	cursorline = true, -- highlight the current line
	-- cursorcolumn = true,
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	encoding = "utf-8", -- Let Vim use utf-8 internally
	fileencoding = "utf-8", -- the encoding written to a file
	-- termencoding = "utf-8", -- Terminal encoding
	fileformats = "unix,dos", -- support all three, in this order
	fileformat = "unix", -- default file format
	pumheight = 10, -- pop up menu height
	showmode = false, -- we don't need to see things like                                                                                                         -- INSERT                                            -- anymore
	showtabline = 2, -- always show tabs
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	timeoutlen = 200, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	numberwidth = 4, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	sidescrolloff = 8,
	guifont = "monospace:h17", -- the font used in graphical neovim applications
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work
