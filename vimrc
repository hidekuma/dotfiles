""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HIDEKUMA's vimrc
" Maintainer: Hidekuma
" Email: d.hidekuma@gmail.com
" Github: https://github.com/hidekuma
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                                       " required by Vundle (re-enabled below)
let s:darwin = has('mac')
" BEFORE
" if isdirectory(expand("~/.vim/bundle/Vundle.vim/"))
"   set rtp+=~/.vim/bundle/Vundle.vim
"   call vundle#begin()

" AFTER
" vim 8~
call plug#begin('~/.vim/plugged')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Basic
"  Plug 'VundleVim/Vundle.vim'                       " let Vundle manage Vundle, required

" Files & Search
Plug 'scrooloose/nerdtree'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'

" Styling
Plug 'vim-airline/vim-airline'          " nice statusline at the bottom of each window 
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'blueyed/vim-diminactive'

" Movement
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-scripts/matchit.zip'

" Theme
Plug 'nanotech/jellybeans.vim'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'NLKNguyen/papercolor-theme'

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

" Syntax / Indenting
Plug 'moby/moby' , {'rtp': '/contrib/syntax/vim/'} " Syntax highlighting for dockerfiles.
Plug 'chr4/nginx.vim'
Plug 'plasticboy/vim-markdown'
Plug 'groenewege/vim-less'
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'Yggdroot/indentLine'
Plug 'tmux-plugins/vim-tmux'
Plug 'scrooloose/vim-slumlord'
Plug 'aklt/plantuml-syntax'
"Plug 'scrooloose/syntastic'
"Plug 'nathanaelkane/vim-indent-guides'

" Preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install()  }  }

" Lint
Plug 'w0rp/ale'

" PHP / Yii
Plug 'mikehaertl/pdv-standalone'
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug '2072/PHP-Indenting-for-VIm'
Plug 'shawncplus/phpcomplete.vim'
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
"Plug 'phpactor/phpactor', { 'do': ':call phpactor#Update()', 'for': 'php' }

" Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'rkulla/pydiction'
Plug 'heavenshell/vim-pydocstring'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'  }

" Vue
Plug 'posva/vim-vue'

" Git
Plug 'tpope/vim-fugitive'

" Auto complete
Plug 'valloric/youcompleteme', { 'do': 'python3 ./install.py --js-completer --ts-completer --java-completer'}
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'

" AFTER
call plug#end()

" BEFORE
"  " End of Vundle plugins
"  call vundle#end()            " required
"endif

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
set autoindent smartindent
set smarttab
set showcmd
set showmatch
set title

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Formatting/Tab settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set formatoptions=tcrqn         " autowrap and comments (see :h 'fo-table)
set autoindent                  " keep indent on next line and make BS work with indenting
set wrap                        " wrap lines that exceed screen
set smarttab                    " Make Tab work fine with spaces
set showmatch                   " show matching brackets
set matchtime=5                 " tenths of a second to blink matching brackets
set hlsearch                    " highlight search phrase matches (reset with :noh)
set incsearch                   " do highlight as you type you search phrase
set list                        " show tabs, trailings spaces, ...
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<


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
set hlsearch incsearch
set cursorline
set cursorcolumn

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set encoding=utf-8              " Let Vim use utf-8 internally
set fileencoding=utf-8          " Default for new files
set termencoding=utf-8          " Terminal encoding
set fileformats=unix,dos,mac    " support all three, in this order
set fileformat=unix             " default file format
set fencs=utf-8,euc-kr          " auto file type check

filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax Highlighting
if has("syntax")
    syntax on
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocmd
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" When editing a file, always jump to the last cursor position.
autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif

" Set some file types by extension
autocmd BufNewFile,BufRead *.xt,*.xd setf xml
autocmd BufNewFile,BufRead *.tpl,*.page,*.vue setf html

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
autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent
autocmd FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent
autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" for java
autocmd BufEnter *.\(c\|cpp\|java\|h\) set et

" PHP settings
" Let the surround plugin use `-` for <?php ?>
autocmd FileType php let b:surround_45 = "<?php \r ?>"
" Let the surround plugin use `=` for <?= ?>
autocmd FileType php let b:surround_61 = "<?= \r ?>"
" Fix javascript word boundaries (erratically activated for PHP files): exclude $
autocmd FileType php setlocal iskeyword-=$

" Function for autodetecting tab settings
function Kees_settabs()
    if len(filter(getbufline(winbufnr(0), 1, "$"), 'v:val =~ "^\\t"')) > len(filter(getbufline(winbufnr(0), 1, "$"), 'v:val =~ "^ "'))
        set noet
    else
        set et
    endif
endfunction
autocmd BufReadPost * call Kees_settabs()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ----------------------------------------------------------------------------
" color
" ----------------------------------------------------------------------------
"color onehalfdark
"let g:airline_theme='onehalflight'
set background=light 
color PaperColor
let g:PaperColor_Theme_Options = {
            \   'theme': {
            \     'default.dark': {
            \       'override' : {
            \         'color00' : ['#080808', '232'],
            \         'linenumber_bg' : ['#080808', '232']
            \       }
            \     }
            \   },
            \   'language': {
            \     'python': {
            \       'highlight_builtins' : 1
            \     },
            \     'cpp': {
            \       'highlight_standard_library': 1
            \     },
            \     'c': {
            \       'highlight_builtins' : 1
            \     }
            \   }
            \ }
let g:airline_theme='papercolor'

" ----------------------------------------------------------------------------
" vim-airline
" ----------------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1        " Enhanced top tabline
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#ale#enabled = 1

" ----------------------------------------------------------------------------
" pymode
" ----------------------------------------------------------------------------
let python_hightlight_all = 1
let g:pymode_python = 'python3'
"let g:pymode_virtualenv = 0
let g:pymode_lint_checkers = ['pyflakes']

" ----------------------------------------------------------------------------
" pydiction
" ----------------------------------------------------------------------------
let g:pydiction_location = '~/.vim/plugged/pydiction/complete-dict'
let g:pydiction_menu_height = 10

" ----------------------------------------------------------------------------
" nerdtree
" ----------------------------------------------------------------------------
nmap ,nt :NERDTree<CR>

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
"hi EasyMotionTarget ctermbg=none ctermfg=darkgreen
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

" vim-indent-guides
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_auto_colors = 0
"let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
"let g:indent_guides_guide_size = 1 
"let g:indent_guides_start_level = 2

" highlight line number
" hi LineNr ctermfg=green cterm=bold

" highlight cursor color
" hi CursorColumn ctermbg=NONE
" hi CursorLine ctermbg=Black cterm=bold

" ----------------------------------------------------------------------------
" tagbar
" ----------------------------------------------------------------------------
nmap <F8> :TagbarToggle<CR>

" ----------------------------------------------------------------------------
" tpope/vim-surround
" ----------------------------------------------------------------------------
let g:surround_indent = 0           " Make indenting on block selection + S work

" ----------------------------------------------------------------------------
" StanAngeloff/php.vim
" ----------------------------------------------------------------------------
let php_sql_query = 1               " Highlight SQL inside strings
let php_parent_error_close = 1      " Highlight parent error ] or )
let php_parent_error_open = 1       " Skip php end tag if there's an unclosed ( or [
let php_folding = 0                 " No folding
let php_sync_method = 0             " Sync from start

" ----------------------------------------------------------------------------
" vim-php-refactoring-toolbox
" ----------------------------------------------------------------------------
let g:vim_php_refactoring_default_property_visibility = 'private'
let g:vim_php_refactoring_default_method_visibility = 'private'
let g:vim_php_refactoring_auto_validate_visibility = 1
let g:vim_php_refactoring_phpdoc = "pdv#DocumentCurrentLine"

let g:vim_php_refactoring_use_default_mapping = 0
nnoremap <leader>prlv :call PhpRenameLocalVariable()<CR>
nnoremap <leader>prcv :call PhpRenameClassVariable()<CR>
nnoremap <leader>prm :call PhpRenameMethod()<CR>
nnoremap <leader>peu :call PhpExtractUse()<CR>
vnoremap <leader>pec :call PhpExtractConst()<CR>
nnoremap <leader>pep :call PhpExtractClassProperty()<CR>
nnoremap <leader>pcp :call PhpCreateProperty()<CR>
nnoremap <leader>pduu :call PhpDetectUnusedUseStatements()<CR>

" ----------------------------------------------------------------------------
" 2072/PHP-Indenting-for-VIm
" ----------------------------------------------------------------------------
let g:PHP_outdentphpescape = 0      " Indent PHP tags as the surrounding non-PHP code
let g:PHP_noArrowMatching = 1       " Don't align arrows of chained method calls
let g:PHP_vintage_case_default_indent = 1   " Indent case: and default: in switch()

" ----------------------------------------------------------------------------
" PDV (PHP Documentor)
" ----------------------------------------------------------------------------
autocmd FileType php nnoremap <C-K> :call PhpDocSingle()<CR>
autocmd FileType php vnoremap <C-K> :call PhpDocRange()<CR>

" ----------------------------------------------------------------------------
" phpactor
" ----------------------------------------------------------------------------
"nnoremap <m-m> :call phpactor#ContextMenu()<cr>
"nnoremap gd :call phpactor#GotoDefinition()<CR>
"nnoremap gr :call phpactor#FindReferences()<CR>

"vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>
"vnoremap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>
"nnoremap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>
"nnoremap <silent><Leader>rei :call phpactor#ClassInflect()<CR>

"let g:phpactor_executable = '~/.vim/plugged/phpactor/bin/phpactor'
"function! PHPModify(transformer)
    ":update
    "let l:cmd = "silent !".g:phpactor_executable." class:transform ".expand('%').' --transform='.a:transformer
    "execute l:cmd
"endfunction

" ----------------------------------------------------------------------------
" vim-scripts/matchit
" ----------------------------------------------------------------------------
let b:match_ignorecase = 1

" ----------------------------------------------------------------------------
" syntastic
" ----------------------------------------------------------------------------
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
""let syntastic_mode_map = { 'passive_filetypes': ['html']  }
"let g:syntastic_always_populate_loc_list = 1
""let g:syntastic_auto_loc_list = 1
""let g:syntastic_check_on_open = 1
""let g:syntastic_check_on_wq = 0

" ----------------------------------------------------------------------------
"fzf
" ----------------------------------------------------------------------------
nnoremap <C-P> :Files<Cr>
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
" php auto complete
" ----------------------------------------------------------------------------
let g:phpcomplete_mappings = {
            \ 'jump_to_def': '<C-]>',
            \ 'jump_to_def_split': '<C-W><C-]>',
            \ 'jump_to_def_vsplit': '<C-W><C-\>',
            \ 'jump_to_def_tabnew': '<C-W><C-[>',
            \}

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

" PHP
let g:ale_php_phpcbf_standard='PSR2'
let g:ale_php_phpcs_standard='phpcs.xml.dist'
let g:ale_php_phpmd_ruleset='phpmd.xml'

" ----------------------------------------------------------------------------
" ycm
" ----------------------------------------------------------------------------
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
let g:ycm_use_clangd = 0
let g:ycm_key_list_select_completion = ['<C-n>']
let g:ycm_key_list_previous_completion=['<C-p>']
let g:ycm_server_python_interpreter = 'python3'
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings = 1
let g:ycm_complete_in_comments = 1
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_filetype_blacklist = {}
let g:ycm_python_binary_path = 'python3'

" ----------------------------------------------------------------------------
" supertab
" ----------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "context"

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
let g:indentLine_char = '¦'
let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'text', 'sh', 'markdown', 'json', 'md']

" ----------------------------------------------------------------------------
" vim-argwrap
" ----------------------------------------------------------------------------
nnoremap <silent> <leader>a :ArgWrap<CR>

" ----------------------------------------------------------------------------
" blueyed/vim-diminactive
" ----------------------------------------------------------------------------
let g:diminactive_enable_focus = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ETC 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ----------------------------------------------------------------------------
" No folding for markdown files
" ----------------------------------------------------------------------------
let g:vim_markdown_folding_disabled=1

" ----------------------------------------------------------------------------
" use scrolling down in WSL
" ----------------------------------------------------------------------------
set term=screen-256color

" ----------------------------------------------------------------------------
" Set paste
" ----------------------------------------------------------------------------
nmap ,P :set paste<CR>
nmap ,p :set nopaste<CR>

" ----------------------------------------------------------------------------
" CSS
" ----------------------------------------------------------------------------
augroup VimCSS3Syntax
    autocmd!
    autocmd FileType css setlocal iskeyword+=-
augroup END

" ----------------------------------------------------------------------------
" WSL -> window clipboard copy
" ----------------------------------------------------------------------------
let s:clip = '/mnt/c/Windows/System32/clip.exe' 
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
    augroup END
end

" ----------------------------------------------------------------------------
" eclim 
" ----------------------------------------------------------------------------
let g:EclimCompletionMethod = 'omnifunc'
"let g:EclimFileTypeValidate = 0
let g:EclimLogLevel = 'error'
let g:EclimSignLevel = 'error'
autocmd FileType java nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
autocmd FileType java nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>
autocmd FileType java nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>

" ----------------------------------------------------------------------------
" macOS
" ----------------------------------------------------------------------------
if s:darwin
    set clipboard=unnamed " use OS clipboard -- brew install reattach-to-user-namespace
    " if brew
    set rtp+=/usr/local/opt/fzf
else
    " if git
    set rtp+=~/.fzf
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" END
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
