local status_ok, neodev = pcall(require, "neodev")
if not status_ok then
	return
end

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
neodev.setup({
	-- add any options here, or leave empty to use the default settings
	library = { plugins = { "nvim-dap-ui" }, types = true },
})
