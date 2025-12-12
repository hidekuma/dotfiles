-- Compatibility shims for plugins using deprecated Neovim APIs.
local M = {}

-- Replace deprecated vim.lsp.start_client with vim.lsp.start when available.
if vim.lsp and vim.lsp.start and vim.lsp.start_client then
  vim.lsp.start_client = function(config)
    return vim.lsp.start(config)
  end
end

-- Map deprecated vim.lsp.buf_get_clients to the new vim.lsp.get_clients helper.
if vim.lsp and vim.lsp.get_clients and vim.lsp.buf_get_clients then
  vim.lsp.buf_get_clients = function(bufnr)
    if bufnr == nil then
      return vim.lsp.get_clients()
    end
    return vim.lsp.get_clients({ bufnr = bufnr })
  end
end

-- Ensure vim.lsp.util.make_position_params can be called without an explicit position_encoding.
if vim.lsp and vim.lsp.util and vim.lsp.util.make_position_params then
  local make_position_params = vim.lsp.util.make_position_params

  local function resolve_bufnr(win)
    if win == nil or win == 0 then
      return vim.api and vim.api.nvim_get_current_buf and vim.api.nvim_get_current_buf() or nil
    end

    if type(win) == "number" then
      if vim.api and vim.api.nvim_win_is_valid and vim.api.nvim_win_is_valid(win) then
        return vim.api.nvim_win_get_buf(win)
      end
      if vim.api and vim.api.nvim_buf_is_valid and vim.api.nvim_buf_is_valid(win) then
        return win
      end
    end

    return vim.api and vim.api.nvim_get_current_buf and vim.api.nvim_get_current_buf() or nil
  end

  local function infer_position_encoding(win)
    local bufnr = resolve_bufnr(win)
    local clients = {}
    if vim.lsp.get_clients then
      clients = vim.lsp.get_clients(bufnr and { bufnr = bufnr } or {})
    elseif vim.lsp.get_active_clients then
      clients = vim.lsp.get_active_clients()
    end

    for _, client in ipairs(clients) do
      if client and client.offset_encoding then
        return client.offset_encoding
      end
    end

    return "utf-16"
  end

  vim.lsp.util.make_position_params = function(win, position_encoding)
    if position_encoding == nil then
      position_encoding = infer_position_encoding(win)
    end
    return make_position_params(win, position_encoding)
  end
end

-- Bridge deprecated vim.tbl_islist to vim.islist to avoid warnings.
if vim.islist and vim.tbl_islist then
  vim.tbl_islist = function(tbl)
    return vim.islist(tbl)
  end
end

return M
