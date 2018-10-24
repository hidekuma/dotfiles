" settings
set nocompatible              " be iMproved, required
filetype off                  " required
syntax on
set nu
set autoindent
set smartindent
set ignorecase
set tabstop=2
set	shiftwidth=2
set expandtab
set showcmd
set showmatch
set title
set ruler
set incsearch
set hlsearch
set cursorline
set cursorcolumn
set encoding=utf-8
set fileencodings=utf-8,euckr


if isdirectory(expand("~/.vim/bundle/Vundle.vim/"))
	" set vundle
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()

	" let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim' "basic
	Plugin 'scrooloose/nerdtree'
	Plugin 'vim-airline/vim-airline'
	Plugin 'airblade/vim-gitgutter'
	Plugin 'scrooloose/syntastic'
	Plugin 'nanotech/jellybeans.vim'	"theme
	Plugin 'chriskempson/vim-tomorrow-theme' "theme
	Plugin 'Valloric/YouCompleteMe'
	Plugin 'terryma/vim-multiple-cursors'
	Plugin 'rkulla/pydiction'
	Plugin 'tpope/vim-fugitive'
	Plugin 'kchmck/vim-coffee-script'
	Plugin 'Raimondi/delimitMate' "{}
	Plugin 'majutsushi/tagbar'
	Plugin 'ctrlpvim/ctrlp.vim'
	Plugin 'nathanaelkane/vim-indent-guides'

	call vundle#end()            " required
	filetype plugin indent on    " required

	"end vundle
	let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
	let g:pydiction_menu_height = 10
	"theme
	color Tomorrow-Night-Eighties
	"color Tomorrow-Night-Blue

  nmap ,nt :NERDTree<CR>

  "vim-multiple-cursor
  let g:multi_cursor_use_default_mapping=0
  " Default mapping
  let g:multi_cursor_next_key='<C-n>'
  let g:multi_cursor_prev_key='<C-p>'
  let g:multi_cursor_skip_key='<C-x>'
  let g:multi_cursor_quit_key='<Esc>'

  "vim-indent-guides
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_auto_colors = 0
  let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
  hi IndentGuidesOdd  ctermbg=black
  hi IndentGuidesEven ctermbg=black
  let g:indent_guides_guide_size = 1 
  let g:indent_guides_start_level = 2
 
	"tagbar
	nmap <F8> :TagbarToggle<CR>

  "ctrlp
	let g:ctrlp_custom_ignore = {
		\ 'dir':  '\.git$\|public$\|log$\|tmp$\|vendor$',
		\ 'file': '\v\.(exe|so|dll)$'
	\ }

endif



