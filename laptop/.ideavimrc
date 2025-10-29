unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim
set mouse-=a

syntax on
set tabstop=4
set shiftwidth=4

set shortmess+=A

set encoding=utf-8

inoremap jj <ESC>
  
set clipboard=unnamed

xnoremap "+y y:call system("wl-copy", @")<cr>
nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
