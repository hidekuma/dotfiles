vim.api.nvim_exec(
[[
let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg
                \ --hidden
                \ --follow
                \ --glob "!.git/*"
                \ --glob "!.gitlab*"
                \ --glob "!node_modules*"
                \ --column
                \ --line-number
                \ --no-heading
                \ --color=always
                \ --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--layout=reverse', '--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()
]],
true)

local opts = { noremap = false, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<leader>p", ":GitFiles<CR>", opts)
keymap("", "<C-P>", ":Files<CR>", opts)
-- keymap("", "<leader>b", ":Buffers<CR>", opts)
keymap("", "<S-F>", ":Rg<CR>", opts)

vim.cmd [[
  augroup _fzf_custom_esc
  autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
  augroup end
]]
