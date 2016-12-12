" Not Vi, ViMproved
set nocompatible
" For Vundle
filetype off

" Set runtime path to include Vundle
set rtp+=~/.vim/bundle/Vundle.vim
" Initialise Vundle
call vundle#begin()

" REQUIRED, Let Vundle manage Vundle, kinda recursive, but whatever
Plugin 'VundleVim/Vundle.vim'

" VIM Airline Plugin and its Themes
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme='spaceport'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Ruby on Rails Plugin
Plugin 'rails.vim'

" Show current git branch
Plugin 'tpope/vim-fugitive'

" Color Code Highlighting Plugin
Plugin 'gko/vim-coloresque'

" UndoTree Plugin and its keybindings
Plugin 'mbbill/undotree'
nmap <C-u> :UndotreeToggle<cr>
if has("persistent_undo")
	" If a file has a persistant undo history, don't clutter its working
	" dir with the persistant undo files
	set undodir=~/.undodir/
	set undofile
endif

" Syntastic Syntax Highlighting
Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_tidy_exec = 'tidy'	" For checking HTML4
let g:syntastic_cpp_include_dirs = ['/usr/local/include','/Applications/Arduino.app/Contents/Java/libraries'] " Mac C Libs
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_cpp_check_header = 1

" Swift Checker Plugin (Autointigrated by Syntastic)
Plugin 'kballard/vim-swift'

" Add Bundler support to vim
Plugin 'tpope/vim-bundler'

" Add rspec support to vim
Plugin 'thoughtbot/vim-rspec'
let g:rspec_runner = "os_x_iterm2"

" Arduino Plugin
Plugin 'jplaut/vim-arduino-ino'
let g:vim_arduino_auto_open_serial = 1

" XCode Plugin
Plugin 'gfontenot/vim-xcode'

" GitGutter Plugin
Plugin 'airblade/vim-gitgutter'

" ViMTeX Plugin
Plugin 'lervag/vimtex'

" Neocomplete Code Completion Plugin
Plugin 'Shougo/neocomplete.vim'

" Close Plugin include area
call vundle#end()
filetype plugin indent on

" Now start normal VIM Config area

" Always show statusline
set laststatus=2

" Don't show default mode indicator, just use airline
set noshowmode

" Show syntax by default
syntax on
" Show line numbers
set number
" Set color of line numbers
hi LineNr term=bold cterm=NONE ctermfg=LightGreen ctermbg=DarkGrey gui=NONE guifg=LightGreen guibg=DarkGrey

" Set color of cursor line number
"if v:version > 700
hi CursorNr term=bold,underline cterm=italic ctermfg=Green ctermbg=DarkGrey gui=italic guifg=Green guibg=DarkGrey
"endif

" Indent depends on file type
if has("autocmd")
	"Enable file type detection
	filetype plugin indent on
endif

" MacVim Font
set gfn=Hack 

" Change tabs with Control+#
nmap <C-1> 1gt
nmap <C-2> 2gt
nmap <C-3> 3gt
nmap <C-4> 4gt
nmap <C-5> 5gt
nmap <C-6> 6gt
nmap <C-7> 7gt
nmap <C-8> 8gt
nmap <C-9> 9gt

" Open tabs with Control+W
nmap <C-w> :tabnew<CR>
" Close tabs with Control+Q
nmap <C-q> :tabclose<CR>
