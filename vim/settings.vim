" Disable vi mode
set nocompatible

" =============
" General config
" =============
" {

" Set default encoding to UTF-8 without BOM
set fileencoding=utf-8
set encoding=utf-8 nobomb

" Enable filetype detection
filetype on
" Enable filetype based plugins
filetype plugin on
" Enable filetype based indentation
filetype indent on

" Enable syntax highlighting by default
syntax on

" Don't add empty lines at the end of files
set binary
set noeol

" Insert 4 spaces when Tab is pressed
set softtabstop=4
" Set tab width to 4 spaces
set tabstop=4
" Use 4 spaces when you press >>, << or ==
set shiftwidth=4
" Copy the indentation from the previous line when starting a new line
set autoindent
" Expand tabs to spaces
set expandtab

" Enable syntax highlighting
syntax on

" Disable flashing and beeping
set noeb vb t_vb=

" Allow backspaces in insert mode
set backspace=2

" Enable line numbers
set number

" Highlight all search matches
set hlsearch
" Move cursor while typing search pattern
set incsearch
" Enable case sensitive search if search pattern contains
" at least one upper case letter
set smartcase
" Ignore case sensitivity in search patterns
set ignorecase

" Create new splits the same size as currently existing ones
set equalalways
" Create new vertical splits on the right side
" to the currently selected split
set splitright
" Create new horizontal splits below the currently selected split
set splitbelow

" Briefly jump to matching brace when inserted
set showmatch
set matchtime=3

" Highlight current line
set cursorline

" Set a line break, so vim won't break words in the middle when wrapping
set linebreak
" Display a wrapper line separator in front of the wrapped lines
let &showbreak='» '
" Continue wrapped line on the indentation as the main line
set breakindent

" Set global flag by default when replacing
set gdefault

" Add spell checker
set spell
" Shortcut for adding a word to spell checker
map <leader>sa zg
" Displays list of suggestions from spell checker
map <leader>s? z=
" Go to next misspelled word
map <leader>sn ]s
" Go to previous misspelled word
map <leader>sp [s

" Define leader key
let mapleader=","

" Add mapping to navigate between splits using the leader key
map <leader>h <C-w>h
map <leader>j <C-w>j
map <leader>k <C-w>k
map <leader>l <C-w>l

" Use dark background by default
set background=dark
" Set color scheme
silent! :colorscheme onedark

" Use system clipboard (make sure vim has clipboard support enabled)
set clipboard=unnamed

" Set fast terminal connection by default, no improve user experience
set ttyfast

" Centralise temporary files location
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif
" Enable undo persistence
if has("persistent_undo")
    set undofile
endif

" Skip backups when editing files from following directories
set backupskip=/tmp/*

" Enable modeline in files. This allows setting specific vim options in a file
set modeline
" Look only at first 4 lines
set modelines=4

" Always show status line below a split
set laststatus=2
" Display cursor current position in status line
set ruler
" Display current editing mode
set showmode
" Enable menu above command line that displays completion options
set wildmenu
" Show the (partial) command as it's being typed
set showcmd

" Hide intro message when Vim is launched
set shortmess=atI

" Show the filename in the window titlebar
set title

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Remember up to 500 history entries
set history=500

" Auto reload files changed outside Vim
set autoread

" Set files that should be globally ignored
set wildignore=.DS_Store
set wildignore+=*.png,*.jpg,*.gif,*.jpeg,*.psd

" Enforce number of colors to 256
set t_Co=256

" Insert only one space after joining
set nojoinspaces

" Display line changes
set report=0

" Display separator at 80 characters width
"set textwidth=80
"set colorcolumn=+1

" Set default shell to zsh
"set shell=zsh

" Don't update the display while running macros
set lazyredraw

" Displays whitespaces
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Edit vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
" Reload vimrc
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Don't highlight cursor line in inactive windows
augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" disable c-c for sql files
let g:omni_sql_no_default_maps = 1

" }
