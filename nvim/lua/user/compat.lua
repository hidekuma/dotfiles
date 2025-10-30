-- Compatibility shims for plugins using deprecated Neovim APIs.
local M = {}

-- Replace deprecated vim.lsp.start_client with vim.lsp.start when available.
if vim.lsp and vim.lsp.start and vim.lsp.start_client then
  vim.lsp.start_client = function(config)
    return vim.lsp.start(config)
  end
end

-- Bridge deprecated vim.tbl_islist to vim.islist to avoid warnings.
if vim.islist and vim.tbl_islist then
  vim.tbl_islist = function(tbl)
    return vim.islist(tbl)
  end
end

-- Provide backwards compatible vim.validate that supports the legacy table form.
do
  local validate_new = vim.validate
  if type(validate_new) == "function" then
    vim.validate = function(arg1, ...)
      if type(arg1) == "table" then
        for name, spec in pairs(arg1) do
          local value = spec[1]
          local validator = spec[2]
          local optional = spec[3]
          local message = spec[4]

          if type(optional) == "string" and message == nil then
            message = optional
            optional = nil
          end

          validate_new(name, value, validator, optional, message)
        end
        return true
      end
      return validate_new(arg1, ...)
    end
  end
end

return M
