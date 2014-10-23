execute pathogen#infect()
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
" Power Line
set t_Co=256
" Syntastic Configuration
let g:syntastic_java_javac_config_file_enabled=1
