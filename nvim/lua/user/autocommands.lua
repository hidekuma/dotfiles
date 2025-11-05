vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  augroup _last_cursor_position
    autocmd!
    autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif
  augroup end

]]


-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.format { async = true }
-- augroup end
vim.api.nvim_create_augroup('AutoFormatting', {})
local function should_format(bufnr)
  if vim.g.disable_autoformat then
    return false
  end

  if vim.b[bufnr].disable_autoformat then
    return false
  end

  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if bufname == "" then
    return false
  end

  local disable_markers = { ".nvim-disable-format", ".disable-format", ".noformat" }
  local dir = vim.fs.dirname(bufname)
  local found = vim.fs.find(disable_markers, {
    path = dir,
    upward = true,
    stop = vim.loop.os_homedir(),
  })

  return vim.tbl_isempty(found)
end

vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'AutoFormatting',
  callback = function(args)
    if not should_format(args.buf) then
      return
    end

    vim.lsp.buf.format({ async = false, bufnr = args.buf })
  end,
})

vim.api.nvim_create_user_command('AutoFormatToggle', function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.b[bufnr].disable_autoformat = not vim.b[bufnr].disable_autoformat
  if vim.b[bufnr].disable_autoformat then
    vim.notify("Autoformat disabled for current buffer", vim.log.levels.INFO)
  else
    vim.notify("Autoformat enabled for current buffer", vim.log.levels.INFO)
  end
end, { desc = 'Toggle LSP autoformat on save for current buffer' })

vim.api.nvim_create_user_command('AutoFormatDisable', function()
  vim.g.disable_autoformat = true
  vim.notify("Autoformat disabled globally", vim.log.levels.INFO)
end, { desc = 'Disable LSP autoformat on save globally' })

vim.api.nvim_create_user_command('AutoFormatEnable', function()
  vim.g.disable_autoformat = false
  vim.notify("Autoformat enabled globally", vim.log.levels.INFO)
end, { desc = 'Enable LSP autoformat on save globally' })
