syntax on                     " ensures syntax highlighting
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Airline Plugin
Plugin 'vim-airline/vim-airline'

" Airline Themes Plugin
Plugin 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Airline Config
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

"Disable gui decorations and set font
if has('gui_running')
  se guioptions-=m  "remove menu bar
  se guioptions-=T  "remove toolbar
  se guioptions-=r  "remove right-hand scroll bar
  se guioptions-=L  "remove left-hand scroll bar
  se guifont=Hack_Regular:h9:cANSI "Set to Source Code Pro font from Adobe
endif
