local status_ok, stabilize = pcall(require, "stabilize")
if not status_ok then
  return
end

stabilize.setup {
	force = true, -- stabilize window even when current cursor position will be hidden behind new window
	forcemark = nil, -- set context mark to register on force event which can be jumped to with '<forcemark>
	ignore = {  -- do not manage windows matching these file/buftypes
		filetype = { "help", "list", "Trouble" },
		buftype = { "terminal", "quickfix", "loclist" }
	},
	nested = nil -- comma-separated list of autocmds that wil trigger the plugins window restore function
}
