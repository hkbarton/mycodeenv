syntax on
set backspace=indent,eol,start
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=8
set number
set autoindent
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1
set encoding=utf-8
if has("gui_macvim")
  set transparency=16
  colorscheme torte
endif
execute pathogen#infect()
