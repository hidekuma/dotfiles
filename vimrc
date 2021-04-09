""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HIDEKUMA's vimrc
" Maintainer: Hidekuma
" Email: d.hidekuma@gmail.com
" Github: https://github.com/hidekuma
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                                       " required by Vundle (re-enabled below)
let s:darwin = has('mac')
call plug#begin('~/.vim/plugged')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files & Search
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'

" Styling
Plug 'vim-airline/vim-airline'          " nice statusline at the bottom of each window 
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'

" Window
Plug 'camspiers/lens.vim'

" Movement
Plug 'Lokaltog/vim-easymotion'

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
Plug 'scrooloose/nerdcommenter'
Plug 'FooSoft/vim-argwrap'
Plug 'terryma/vim-expand-region'
Plug 'KabbAmine/vCoolor.vim' " Color picker

" Syntax / Indenting
" TODO:Check
Plug 'moby/moby' , {'rtp': '/contrib/syntax/vim/'} " Syntax highlighting for dockerfiles. 
" TODO:Check
Plug 'plasticboy/vim-markdown'
"Plug 'pangloss/vim-javascript'
"Plug 'othree/html5.vim'
"Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'Yggdroot/indentLine'
"Plug 'scrooloose/vim-slumlord' "Plantuml
"Plug 'aklt/plantuml-syntax'
Plug 'tikhomirov/vim-glsl'

" Preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install()  }  }

" Lint
Plug 'w0rp/ale'

" Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

" Git
Plug 'tpope/vim-fugitive'
Plug 'rhysd/git-messenger.vim'

" Auto complete
Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set wildmenu                    " Show suggestions on TAB for some commands
set ruler                       " Always show current positions along the bottom
set cmdheight=1                 " the command bar is 1 high
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
"let g:python3_host_prog = '/Users/hyunlang/miniconda3/bin/python'
let g:coc_global_extensions =
            \ ['coc-ultisnips',
            \ 'coc-fzf-preview',
            \ 'coc-explorer',
            \ 'coc-yaml',
            \ 'coc-git',
            \ 'coc-tsserver',
            \ 'coc-python',
            \ 'coc-java',
            \ 'coc-json',
            \ 'coc-html',
            \ 'coc-css' ]

" ----------------------------------------------------------------------------
" vim-airline
" ----------------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1        " Enhanced top tabline
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#ale#enabled = 1


" ----------------------------------------------------------------------------
" vim-gitgutter
" ----------------------------------------------------------------------------
if !s:darwin
    let g:gitgutter_git_executable = 'git.exe'
endif

" ----------------------------------------------------------------------------
" pymode
" ----------------------------------------------------------------------------
let python_hightlight_all = 1
let g:pymode_python = 'python3'
let g:pymode_virtualenv = 1
let g:pymode_lint_checkers = ['pyflakes']

if s:darwin
    let g:pymode_rope = 1
endif

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
nmap <F8> :TagbarToggle<CR>

" ----------------------------------------------------------------------------
" tpope/vim-surround
" ----------------------------------------------------------------------------
let g:surround_indent = 0           " Make indenting on block selection + S work

" ----------------------------------------------------------------------------
"fzf
" ----------------------------------------------------------------------------
nnoremap <silent> <leader>p :GitFiles<CR>
nnoremap <C-P> :Files<CR>
nmap <S-F> :Rg<CR>
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
                \ --column
                \ --line-number
                \ --no-heading
                \ --color=always
                \ --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--no-color', '--layout=reverse', '--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

"function! s:fzf_statusline()
  "" Override statusline as you like
  "highlight fzf1 ctermfg=161 ctermbg=251
  "highlight fzf2 ctermfg=23 ctermbg=251
  "highlight fzf3 ctermfg=237 ctermbg=251
  "setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
"endfunction

"autocmd! User FzfStatusLine call <SID>fzf_statusline()


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
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_completion_enabled = 1
let g:ale_open_list = 1
let g:ale_keep_list_window_open=0
let g:ale_set_quickfix=0
let g:ale_list_window_size = 5
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_delay = 1500
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

set statusline=%{LinterStatus()}

" ----------------------------------------------------------------------------
" ycm
" ----------------------------------------------------------------------------
"nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
"let g:ycm_use_clangd = 0
"let g:ycm_key_list_select_completion = ['<C-n>']
"let g:ycm_key_list_previous_completion=['<C-p>']
""let g:ycm_server_python_interpreter
"let g:ycm_python_interpreter_path = ''
"let g:ycm_python_sys_path = []
"let g:ycm_extra_conf_vim_data = [
  "\  'g:ycm_python_interpreter_path',
  "\  'g:ycm_python_sys_path'
  "\]
"let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'
"let g:ycm_collect_identifiers_from_comments_and_strings = 1
"let g:ycm_complete_in_strings = 1
"let g:ycm_complete_in_comments = 1
"let g:ycm_min_num_of_chars_for_completion = 2
"let g:ycm_filetype_blacklist = {}
"let g:ycm_python_binary_path = 'python3'

" ----------------------------------------------------------------------------
" ultisnips
" ----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<C-x>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['ultisnips']
" PHP7
let g:ultisnips_php_scalar_types = 1

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

" ----------------------------------------------------------------------------
" vim-glsl
" ----------------------------------------------------------------------------
autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ETC 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ----------------------------------------------------------------------------
" ETC mapping keys
" ----------------------------------------------------------------------------
if has('nvim')
    :tnoremap <A-h> <C-\><C-n><C-w>h
    :tnoremap <A-j> <C-\><C-n><C-w>j
    :tnoremap <A-k> <C-\><C-n><C-w>k
    :tnoremap <A-l> <C-\><C-n><C-w>l
endif
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

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
    let s:vimDir = '$HOME/.vim'
    let &runtimepath.=','.s:vimDir
    let s:undoDir = expand(s:vimDir . '/undodir')

    call system('mkdir ' . s:vimDir)
    call system('mkdir ' . s:undoDir)

    let &undodir = s:undoDir
    set undofile
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
