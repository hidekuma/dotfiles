local dap_ok, dap = pcall(require, "mason-nvim-dap")
local dap_ui_ok, _ = pcall(require, "dapui")

if not (dap_ok and dap_ui_ok) then
	require("notify")("nvim-dap or dap-ui not installed!", "warning") -- nvim-notify is a separate plugin, I recommend it too!
	return
end


require("user.dap.configs")
require("user.dap.commands")
require("user.dap.adapters")
require("user.dap.ui")
