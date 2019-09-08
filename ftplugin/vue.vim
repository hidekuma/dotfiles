" Run both javascript and vue linters for vue files.
"let b:ale_linter_aliases = ['javascript', 'vue', 'html']
" Select the eslint and vls linters.
let g:ale_linters = {
      \ 'html': [],
      \ 'css': ['stylelint'],
      \ 'javascript': ['eslint'],
      \ 'vue': ['eslint']
      \ }
let g:ale_linter_aliases = {'vue': 'css'}
