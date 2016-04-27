"NeoBundle Scripts-----------------------------
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'derekwyatt/vim-scala'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------
"execute pathogen#infect()
syntax on
set nocompatible
" Theme
set background=dark
colorscheme solarized
if has("gui_macvim")
  set transparency=4
endif
" Typing
set backspace=indent,eol,start
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set number
set autoindent
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1
set encoding=utf-8
set laststatus=2
set binary
set noeol
" Power Line
set t_Co=256
" Syntastic Configuration
let g:syntastic_java_javac_config_file_enabled=1
" Use eslint as javascript checker
let g:syntastic_javascript_checkers=['eslint']
let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let g:syntastic_javascript_eslint_exec = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
" For ctrlp file search plugin
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map='<c-p>'
" NERDTree shortcut
map <C-n> :NERDTreeToggle<CR>
