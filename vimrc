""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HIDEKUMA's vimrc
" Maintainer: Hidekuma
" Email: d.hidekuma@gmail.com
" Github: https://github.com/hidekuma
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
let s:darwin = has('mac')
let s:windows = has('win32') || has('win64')
call plug#begin('~/.vim/plugged')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files & Search
Plug 'scrooloose/nerdtree'
Plug 'Shougo/context_filetype.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'

" Styling
Plug 'vim-airline/vim-airline'          " nice statusline at the bottom of each window
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'blueyed/vim-diminactive'
Plug 'ryanoasis/vim-devicons'

" Window
Plug 'camspiers/lens.vim'

" Movement
Plug 'Lokaltog/vim-easymotion'

" Tag
" Plug 'ludovicchabant/vim-gutentags' "  run ctags when save file
" Plug 'preservim/tagbar'

" Theme
Plug 'NLKNguyen/papercolor-theme'
Plug 'cocopon/iceberg.vim'

" Editing utilities
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'terryma/vim-multiple-cursors'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'FooSoft/vim-argwrap'
Plug 'terryma/vim-expand-region'
Plug 'KabbAmine/vCoolor.vim' " Color picker
Plug 'bitc/vim-bad-whitespace'

" Syntax / Indenting
Plug 'moby/moby' , {'rtp': '/contrib/syntax/vim/'} " Syntax highlighting for dockerfiles.
Plug 'plasticboy/vim-markdown'
Plug 'Yggdroot/indentLine'
Plug 'tikhomirov/vim-glsl'
Plug 'evanleck/vim-svelte', {'branch': 'main'}

" Preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install()  }  }

" Lint
"Plug 'w0rp/ale'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

" Python
" Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

" Git
Plug 'tpope/vim-fugitive'
Plug 'rhysd/git-messenger.vim'

" Auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'

" Debug
Plug 'puremourning/vimspector'

" AFTER
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible                " be iMproved, required
set history=50                  " How many lines of history to remember
set confirm                     " Ask for confirmation in some situations (:q)
set ignorecase smartcase        " case insensitive search, except when mixing cases
set modeline                    " we allow modelines in textfiles to set vim settings
set hidden                      " allows to change buffer without saving
set mouse=a                     " enable mouse in all modes
set noerrorbells                " don't make noise
set novisualbell                " don't blink
set t_Co=256                    " Enable 256 color mode
set exrc                        " Scan working dir for .vimrc

" Some servers have issues with backup files
set nobackup
set nowritebackup

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Formatting/Tab settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set formatoptions=tcrqn         " autowrap and comments (see :h 'fo-table)
set autoindent smartindent      " keep indent on next line and make BS work with indenting
set wrap                        " wrap lines that exceed screen
set smarttab                    " Make Tab work fine with spaces
set showmatch                   " show matching brackets
set matchtime=5                 " tenths of a second to blink matching brackets
set hlsearch                    " highlight search phrase matches (reset with :noh)
set incsearch                   " do highlight as you type you search phrase
set list                        " show tabs, trailings spaces, ...
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<
set showcmd
set title
set conceallevel=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set wildmenu                    " Show suggestions on TAB for some commands
set ruler                       " Always show current positions along the bottom
set cmdheight=1                 " the command bar is 2 high
set number                      " turn on line numbers
set lazyredraw                  " do not redraw while running macros (much faster)
set backspace=indent,eol,start  " make backspace work normal
set whichwrap+=<,>,h,l          " make cursor keys and h,l wrap over line endings
set report=0                    " always report how many lines where changed
set fillchars=vert:\ ,stl:\ ,stlnc:\    " make the splitters between windows be blank
set laststatus=2                " always show the status line
set scrolloff=10                " Start scrolling this number of lines from top/bottom
set cursorline
set cursorcolumn
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
set updatetime=300
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


" a.link hidden
let g:indentLine_concealcursor = "nc"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nvim settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
" GoBack : C-o
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gs :split<CR><Plug>(coc-definition)
nmap <silent> gv :vsplit<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" codelens
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" Python Provider
let g:loaded_python_provider = 0
let g:python3_host_prog='~/.virtualenvs/neovim3.9/bin/python'

" Python doq
nmap <silent> ga <Plug>(coc-codeaction-line)
xmap <silent> ga <Plug>(coc-codeaction-selected)
nmap <silent> gA <Plug>(coc-codeaction)

" coc-translator
" popup
" nmap <Leader>t <Plug>(coc-translator-p)
" vmap <Leader>t <Plug>(coc-translator-pv)
" echo
" nmap <Leader>e <Plug>(coc-translator-e)
" vmap <Leader>e <Plug>(coc-translator-ev)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tmux settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set encoding=utf-8              " Let Vim use utf-8 internally
set fileencoding=utf-8          " Default for new files
set termencoding=utf-8          " Terminal encoding
set fileformats=unix,dos,mac    " support all three, in this order
set fileformat=unix             " default file format
set fencs=utf-8,euc-kr          " auto file type check

filetype plugin indent on       " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax Highlighting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("syntax")
    syntax on
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocmd
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Global indent settings
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" Indenting per file type
"  - tabstop:       number of spaces inserted for each tab
"  - softtabstop:   make spaces feel like real tabs (e.g. for backspace)
"  - shiftwidth:    number of spaces for indentation (e.g. > and < )
"  - expandtab:     use spaces instaed of Tab. <c-v><TAB> gives real Tab
"  - autoindent:    keep indenting of previous line
autocmd FileType php setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent
autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent
autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType svelte setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent

" When editing a file, always jump to the last cursor position.
autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif

" Set some file types by extension
autocmd BufNewFile,BufRead *.xt,*.xd setf xml
autocmd BufNewFile,BufRead *.tpl,*.page,*.vue setf html

" for java
autocmd BufEnter *.\(c\|cpp\|java\|h\) set et

" CSS
augroup VimCSS3Syntax
    autocmd!
    autocmd FileType css setlocal iskeyword+=-
augroup END

" vim-glsl
autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

" Automatically removing all trailing whitespace
autocmd BufWritePre *.py %s/\s\+$//e

" cp file path
nmap cp :let @+ = expand("%")<cr>
nmap cP :let @+ = expand("%:p")<cr>

" cursor matching words
" autocmd CursorMoved * exe printf('match CocListBlueBlack /\V\<%s\>/', escape(expand('<cword>'), '/\'))

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ----------------------------------------------------------------------------
" color
" ----------------------------------------------------------------------------
set background=dark
colorscheme iceberg

" ----------------------------------------------------------------------------
" coc.nvim
" ----------------------------------------------------------------------------
nnoremap <space>e :CocCommand explorer<CR>
let g:coc_global_extensions =
            \ ['coc-ultisnips',
            \ 'coc-snippets',
            \ 'coc-fzf-preview',
            \ 'coc-explorer',
            \ 'coc-yaml',
            \ 'coc-git',
            \ 'coc-tsserver',
            \ 'coc-pyright',
            \ 'coc-kotlin',
            \ 'coc-tabnine',
            \ 'coc-pydocstring',
            \ 'coc-phpls',
            \ 'coc-java',
            \ 'coc-eslint',
            \ 'coc-json',
            \ 'coc-html',
            \ 'coc-svelte',
            \ 'coc-css' ]

" ----------------------------------------------------------------------------
" coc-snippets
" ----------------------------------------------------------------------------
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" ----------------------------------------------------------------------------
" vim-diminactive
" ----------------------------------------------------------------------------
let g:diminactive_enable_focus = 1
let g:diminactive_use_syntax = 1

" ----------------------------------------------------------------------------
" vim-airline
" ----------------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1        " Enhanced top tabline
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#ale#enabled = 1

" ----------------------------------------------------------------------------
" vim-svelte
" ----------------------------------------------------------------------------
"let g:svelte_preprocessors = ['typescript']

" ----------------------------------------------------------------------------
" vim-prettier
" ----------------------------------------------------------------------------
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat_require_pragma = 0
au BufWritePre *.css,*.svelte,*.pcss,*.html,*.ts,*.js,*.json PrettierAsync

" ----------------------------------------------------------------------------
" vim-gitgutter
" ----------------------------------------------------------------------------
"if !s:darwin
    "let g:gitgutter_git_executable = 'git.exe'
"endif

" ----------------------------------------------------------------------------
" pymode
" ----------------------------------------------------------------------------
" let python_hightlight_all = 1
" let g:pymode_python = 'python3'
" let g:pymode_virtualenv = 1
" let g:pymode_lint_checkers = []
" let g:pymode_lint_checkers = ['pyflakes']

" if !s:darwin
"     let g:pymode = 0
" endif

" ----------------------------------------------------------------------------
" context_filetype
" ----------------------------------------------------------------------------
 if !exists('g:context_filetype#same_filetypes')
   let g:context_filetype#filetypes = {}
 endif

 let g:context_filetype#filetypes.svelte =
 \ [
 \   {'filetype' : 'javascript', 'start' : '<script \?.*>', 'end' : '</script>'},
 \   {
 \     'filetype': 'typescript',
 \     'start': '<script\%( [^>]*\)\? \%(ts\|lang="\%(ts\|typescript\)"\)\%( [^>]*\)\?>',
 \     'end': '',
 \   },
 \   {'filetype' : 'css', 'start' : '<style \?.*>', 'end' : '</style>'},
 \ ]

let g:ft = ''
" ----------------------------------------------------------------------------
" NERDCommenter settings
" ----------------------------------------------------------------------------
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCustomDelimiters = { 'html': { 'left': '<!--', 'right': '-->' } }
let g:NERDDefaultAlign = 'left'

fu! NERDCommenter_before()
  if (&ft == 'html') || (&ft == 'svelte')
  let g:ft = &ft
  let cfts = context_filetype#get_filetypes()
  if len(cfts) > 0
    if cfts[0] == 'svelte'
      let cft = 'html'
    elseif cfts[0] == 'scss'
      let cft = 'css'
    else
      let cft = cfts[0]
    endif
    exe 'setf ' . cft
    endif
  endif
endfu

fu! NERDCommenter_after()
  if (g:ft == 'html') || (g:ft == 'svelte')
  exec 'setf ' . g:ft
  let g:ft = ''
  endif
endfu

" ----------------------------------------------------------------------------
" nerdtree
" ----------------------------------------------------------------------------
nmap ,nt :NERDTree<CR>

" ----------------------------------------------------------------------------
" git-messenger
" ----------------------------------------------------------------------------
nmap gm :GitMessenger<CR>

" ----------------------------------------------------------------------------
" vim-multiple-cursor
" ----------------------------------------------------------------------------
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" ----------------------------------------------------------------------------
" vimspector
" ----------------------------------------------------------------------------
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-java-debug' ]
let g:vimspector_enable_mappings = 'HUMAN'

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval

" ----------------------------------------------------------------------------
" vim-easymotion
" ----------------------------------------------------------------------------
"hi EasyMotionTarget cterbg=none ctermfg=darkgreen
"hi EasyMotionShade  ctermbg=none ctermfg=gray
"hi EasyMotionTarget2First ctermbg=none ctermfg=darkred
"hi EasyMotionTarget2Second ctermbg=none ctermfg=darkblue
hi link EasyMotionTarget Search
hi link EasyMotionTarget2First Search
hi link EasyMotionTarget2Second Search
hi link EasyMotionShade Comment
let g:EasyMotion_leader_key=','
"map  / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)
map ,l <Plug>(easymotion-lineforward)
map ,j <Plug>(easymotion-j)
map ,k <Plug>(easymotion-k)
map ,h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion"
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

" ----------------------------------------------------------------------------
" tagbar
" ----------------------------------------------------------------------------
" nmap <F8> :TagbarToggle<CR>

" ----------------------------------------------------------------------------
" tpope/vim-surround
" ----------------------------------------------------------------------------
let g:surround_indent = 0           " Make indenting on block selection + S work

" ----------------------------------------------------------------------------
"fzf
" ----------------------------------------------------------------------------
map <leader>p :GitFiles<CR>
map <C-P> :Files<CR>
map <leader>b :Buffers<cr>
map <S-F> :Rg<CR>
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

" ----------------------------------------------------------------------------
" nerdtree
" ----------------------------------------------------------------------------
let g:NERDTreeWinSize = 30

" ----------------------------------------------------------------------------
" emmet
" ----------------------------------------------------------------------------
let g:user_emmet_settings = {
            \  'php' : {
            \    'extends' : 'html',
            \    'filters' : 'c',
            \  },
            \  'xml' : {
            \    'extends' : 'html',
            \  },
            \  'haml' : {
            \    'extends' : 'html',
            \  },
            \  'tpl' : {
            \    'extends' : 'html',
            \  },
            \}

" ----------------------------------------------------------------------------
" ALE
" ----------------------------------------------------------------------------
"let g:ale_sign_error = '>>'
"let g:ale_sign_warning = '--'
"let g:ale_completion_enabled = 1
"let g:ale_open_list = 1
"let g:ale_keep_list_window_open=0
"let g:ale_set_quickfix=0
"let g:ale_list_window_size = 5
"let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"let g:ale_lint_delay = 1500
"function! LinterStatus() abort
    "let l:counts = ale#statusline#Count(bufnr(''))

    "let l:all_errors = l:counts.error + l:counts.style_error
    "let l:all_non_errors = l:counts.total - l:all_errors

    "return l:counts.total == 0 ? 'OK' : printf(
    "\   '%dW %dE',
    "\   all_non_errors,
    "\   all_errors
    "\)
"endfunction

"set statusline=%{LinterStatus()}

" ----------------------------------------------------------------------------
" ultisnips
" ----------------------------------------------------------------------------
"let g:UltiSnipsExpandTrigger="<C-x>"
"let g:UltiSnipsJumpForwardTrigger="<Tab>"
"let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
"let g:UltiSnipsEditSplit="vertical"
"let g:UltiSnipsSnippetDirectories = ['ultisnips']
" PHP7
"let g:ultisnips_php_scalar_types = 1

" ----------------------------------------------------------------------------
" indentline
" ----------------------------------------------------------------------------
let g:indentLine_char = '┊'
let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'text', 'sh', 'markdown', 'json', 'md']

" ----------------------------------------------------------------------------
" vim-argwrap
" ----------------------------------------------------------------------------
nnoremap <silent> <leader>a :ArgWrap<CR>
" ----------------------------------------------------------------------------
" vim-markdown
" ----------------------------------------------------------------------------
let g:vim_markdown_folding_disabled=1


" ----------------------------------------------------------------------------
" lens
" ----------------------------------------------------------------------------
let g:lens#disabled_filetypes = ['nerdtree', 'fzf', 'coc-explorer']
let g:lens#height_resize_max = 20
let g:lens#height_resize_min = 5
let g:lens#width_resize_max = 80
let g:lens#width_resize_min = 20


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ETC
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ----------------------------------------------------------------------------
" ETC mapping keys
" ----------------------------------------------------------------------------
if has('nvim')
    :tnoremap <S-h> <C-\><C-n><C-w>h
    :tnoremap <S-j> <C-\><C-n><C-w>j
    :tnoremap <S-k> <C-\><C-n><C-w>k
    :tnoremap <S-l> <C-\><C-n><C-w>l
    :tnoremap <C-c> <C-\><C-n><C-w>c
endif
:nnoremap <S-h> <C-w>h
:nnoremap <S-j> <C-w>j
:nnoremap <S-k> <C-w>k
:nnoremap <S-l> <C-w>l
:nnoremap <C-c> <C-w>c



nmap ,P :set paste<CR>
nmap ,p :set nopaste<CR>
nmap <S-Tab> :tabprev<Return>
nmap <Tab> :tabnext<Return>
nmap sh :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
nmap tn :tabnew<Return>

" window resize
map <C-w><left> <C-w><
map <C-w><right> <C-w>>
map <C-w><up> <C-w>+
map <C-w><down> <C-w>-

" set paste
nmap ,P :set paste<CR>
nmap ,p :set nopaste<CR>

" ----------------------------------------------------------------------------
" vim-persistent-undo
" ----------------------------------------------------------------------------
if has('persistent_undo')
    if s:darwin
        let s:vimDir = '$HOME/.vim'
        let &runtimepath.=','.s:vimDir
        let s:undoDir = expand(s:vimDir . '/undodir')

        call system('mkdir ' . s:vimDir)
        call system('mkdir ' . s:undoDir)

        let &undodir = s:undoDir
        set undofile
    endif
endif

" ----------------------------------------------------------------------------
" macOS
" ----------------------------------------------------------------------------
if s:darwin
    set clipboard=unnamed " use OS clipboard -- brew install reattach-to-user-namespace
    " if brew
    set rtp+=/usr/local/opt/fzf
else
    " https://github.com/equalsraf/win32yank/releases
    let s:clip = '/mnt/d/win32yank.exe'
    if executable(s:clip)
        set clipboard+=unnamedplus
        let g:clipboard = {
        \   'name': 'win32yank-wsl',
        \   'copy': {
        \      '+': 'win32yank.exe -i --crlf',
        \      '*': 'win32yank.exe -i --crlf',
        \    },
        \   'paste': {
        \      '+': 'win32yank.exe -o --lf',
        \      '*': 'win32yank.exe -o --lf',
        \   },
        \   'cache_enabled': 0,
        \ }
        " use scrolling down in WSL
    end
    if !has('nvim')
        set term=screen-256color
    endif

    " if git
    set rtp+=~/.fzf
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" END
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
