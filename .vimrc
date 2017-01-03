" THE FOLLOWING LINE MUST BE FIRST (paradox kinda, as this line is first)
set t_Co=256	" Set 256 colours graphics

" Leader is a space
let mapleader=" "
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
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" Key Remapings
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
	" For no inserting <CR> key.
	"return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Code Alignment Plugin, for when the repo you clone doesnt do stuff right and
" you spend ten hours fixing their alignment and style to be possible to even
" look at without your eyes bleeding, then make the change, then your pull
" gets rejected because they find your style and alignment terrible because
" they are terrible.
Plugin 'junegunn/vim-easy-align'

" Limelight Plugin
Plugin 'junegunn/limelight.vim'
nmap <Leader>l <Plug>(Limelight)
xmap <Leader>l <Plug>(Limelight)

" COments (you can tell i did this b4 plug cause it looks like crap)
Plugin 'scrooloose/nerdcommenter'

" My own plugin :) (which sucks and crashes)
"Plugin 'jellyfishcoder/iVim'

" Close Plugin include area
call vundle#end()
filetype plugin indent on

" Now start normal VIM Config area

function RangerExplorer()
	exec "silent !ranger --choosefile=/tmp/vim_ranger_current_file " . expand("%:p:h")
	if filereadable('/tmp/vim_ranger_current_file')
		exec 'edit ' . system('cat /tmp/vim_ranger_current_file')
		call system('rm /tmp/vim_ranger_current_file')
	endif
	redraw!
endfun
map <Leader>x :call RangerExplorer()<CR>

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
