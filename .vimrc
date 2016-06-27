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

" Codeclimate Plugin
Plugin 'wfleming/vim-codeclimate'

" Ruby on Rails Plugin
Plugin 'rails.vim'

" Syntastic Syntax Highlighting
Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_tidy_exec = 'tidy'	" For checking HTML5

" Swift Checker Plugin (Autointigrated by Syntastic)
Plugin 'kballard/vim-swift'

" Add bundler support to vim
Plugin 'tpope/vim-bundler'

" Add rspec support to vim
Plugin 'thoughtbot/vim-rspec'
let g:rspec_runner = "os_x_iterm2"

" Close Plugin include area
call vundle#end()
filetype plugin indent on

" Now start normal VIM Config area

" Something with powerline
" set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
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
if v:version > 700
	hi CursorNr term=bold,underline cterm=bold ctermfg=LightGreen ctermbg=DarkGrey gui=bold guifg=LightGreen guibg=DarkGrey
endif

" Indent depends on file type
if has("autocmd")
	"Enable file type detection
	filetype plugin indent on
endif

" Change tabs with <D-#>
map <C-1> 1gt
map <C-2> 2gt
map <C-3> 3gt
map <C-4> 4gt
map <C-5> 5gt
map <C-6> 6gt
map <C-7> 7gt
map <C-8> 8gt
map <C-9> 9gt

" Open tabs with <D-t>
map <C-w> :tabnew<CR>
map <C-q> :tabclose<CR>

" Change tabs with <C-Tab>
map <C-Tab> :tabn<CR>
map <C-S-Tab> :tabp<CR>
