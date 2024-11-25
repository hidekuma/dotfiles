local status_ok, wk = pcall(require, "which-key")
if not status_ok then
	return
end

local mappings = {
	{ "<leader>a",  "<cmd>Alpha<cr>",                                                   desc = "Alpha" },
	{ "<leader>A",  "<cmd>ArgWrap<cr>",                                                 desc = "ArgWrap" },
	{ "<leader>e",  "<cmd>NvimTreeToggle<cr>",                                          desc = "Explorer" },
	{ "<leader>w",  "<cmd>w!<CR>",                                                      desc = "Save" },
	{ "<leader>Q",  "<cmd>q!<CR>",                                                      desc = "Quit" },
	{ "<leader>c",  "<cmd>Bdelete!<CR>",                                                desc = "Close Buffer" },
	{ "<leader>h",  "<cmd>nohlsearch<CR>",                                              desc = "No Highlight" },
	{ "<leader>P",  "<cmd>lua require('telescope').extensions.projects.projects()<cr>", desc = "Projects" },
	{ "<leader>pc", "<cmd>PackerCompile<cr>",                                           desc = "Compile" },
	{ "<leader>pi", "<cmd>PackerInstall<cr>",                                           desc = "Install" },
	{ "<leader>ps", "<cmd>PackerSync<cr>",                                              desc = "Sync" },
	{ "<leader>pS", "<cmd>PackerStatus<cr>",                                            desc = "Status" },
	{ "<leader>pu", "<cmd>PackerUpdate<cr>",                                            desc = "Update" },
	{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",                           desc = "Code Action" },
	{ "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>",                           desc = "Document Diagnostics" },
	{ "<leader>lw", "<cmd>Telescope diagnostics<cr>",                                   desc = "Workspace Diagnostics" },
	{ "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>",                desc = "Format" },
	{ "<leader>li", "<cmd>Mason<cr>",                                                   desc = "Info" },
	{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>",                          desc = "Next Diagnostic" },
	{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>",                          desc = "Prev Diagnostic" },
	{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",                                desc = "Rename" },
	{ "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>",                          desc = "Document Symbols" },
	{ "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",                 desc = "Workspace Symbols" },
}

wk.add(mappings)
