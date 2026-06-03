" Compat shim: nvim 0.10+ removed the vimscript health API.
" Unmaintained plugins (e.g. vim-translator) still call health#report_*.
function! health#report_ok(msg) abort
  call v:lua.vim.health.ok(a:msg)
endfunction

function! health#report_info(msg) abort
  call v:lua.vim.health.info(a:msg)
endfunction

function! health#report_warn(msg, ...) abort
  call v:lua.vim.health.warn(a:msg, get(a:, 1, []))
endfunction

function! health#report_error(msg, ...) abort
  call v:lua.vim.health.error(a:msg, get(a:, 1, []))
endfunction

function! health#report_start(msg) abort
  call v:lua.vim.health.start(a:msg)
endfunction
