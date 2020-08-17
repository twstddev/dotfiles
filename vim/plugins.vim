call plug#begin('~/.vim/bundle')

" =========
" Appearance
" =========
" Colors
Plug 'goatslacker/mango.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'sjl/badwolf'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'w0ng/vim-hybrid'
Plug 'junegunn/seoul256.vim'
Plug 'zeis/vim-kolor'
Plug 'noahfrederick/vim-hemisu'
Plug 'vim-scripts/Colour-Sampler-Pack'
Plug 'daylerees/colour-schemes', { 'rtp': 'vim' }
Plug 'petelewis/vim-evolution'
Plug 'joshdick/onedark.vim'
Plug 'mkarmona/materialbox'
Plug 'DrowsySaturn/VIvid.vim'
Plug 'gilgigilgil/anderson.vim'
Plug 'jdkanani/vim-material-theme'
Plug 'cdmedia/itg_flat_vim'
Plug 'gosukiwi/vim-atom-dark'
Plug 'MaxSt/FlatColor'
Plug 'baskerville/bubblegum'
Plug 'jordwalke/flatlandia'
Plug 'whatyouhide/vim-gotham'
Plug 'blerins/flattown'
Plug 'yosiat/oceanic-next-vim'
Plug 'wellsjo/wellsokai.vim'
Plug 'duythinht/inori'
Plug 'nice/sweater'
Plug 'john2x/flatui.vim'
Plug 'raphamorim/lucario'
Plug 'ronny/birds-of-paradise.vim'
Plug 'hhff/SpacegrayEighties.vim'
Plug 'KabbAmine/yowish.vim'
Plug 'crusoexia/vim-dream'
Plug 'tristen/superman'
Plug 'AlessandroYorba/Sierra'
Plug 'AlessandroYorba/Alduin'
Plug 'atelierbram/vim-colors_duotones'
Plug 'ninja/sky'
Plug 'jacoborus/tender.vim'
Plug 'bcicen/vim-vice'
Plug 'dracula/vim'
Plug 'aereal/vim-colors-japanesque'
Plug 'rakr/vim-two-firewatch'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'notpratheek/vim-luna'
Plug 'easysid/mod8.vim'
Plug 'jscappini/material.vim'
Plug 'trusktr/seti.vim'
Plug 'AlessandroYorba/Despacio'

" ==============
" Utility helpers for other plugins
" ==============
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'xolox/vim-misc'

" ======
" Editor
" ======
" File explorer for vim
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Plugin for intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'
" Plugin provides mappings to easily delete, change and add such surroundings in pairs
Plug 'tpope/vim-surround'
" The missing motion for Vim
Plug 'justinmk/vim-sneak'
" Enable repeating supported plugin maps with .
Plug 'tpope/vim-repeat'
" Show 'Match 123 of 456 /search term/' in Vim searches
Plug 'henrik/vim-indexed-search'
" A light and configurable statusline/tabline for Vim
Plug 'itchyny/lightline.vim'
" Provides automatic closing of quotes, parenthesis, brackets, etc.
Plug 'Raimondi/delimitMate'
" Extended % matching for HTML, LaTeX, and many other languages
Plug 'tmhedberg/matchit'
" Plugin to toggle, display and navigate marks
Plug 'kshenoy/vim-signature'
" Plugin maintains a history of previous yanks, changes and deletes
Plug 'vim-scripts/YankRing.vim'
" Edit large files quickly
Plug 'vim-scripts/LargeFile'
" Hyperfocus-writing in Vim
Plug 'junegunn/limelight.vim'
" Vim plugin that provides additional text objects
Plug 'wellle/targets.vim'
" Distraction-free writing in Vim
Plug 'junegunn/goyo.vim'
" Changes Vim working directory to project root (identified by presence of known directory or file)
" There seems to be a bug that doesn't really change cwd and some plugins stop
" working (easygrep, ycm - ternjs)
Plug 'airblade/vim-rooter'
" Pasting in Vim with indentation adjusted to destination context
Plug 'sickill/vim-pasta'
" Make gvim-only colorschemes work transparently in terminal vim
Plug 'godlygeek/csapprox'
" Script for text filtering and alignment ( keep it because some other plugins
" require it. puppet )
Plug 'godlygeek/tabular'

if g:ycm_supported
    " A code-completion engine for Vim ( the plugin is very useful but it makes the whole editor slow )
    Plug 'Valloric/YouCompleteMe'
endif

" A vim plugin to display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine'
" Fuzzy file, buffer, mru, tag, etc finder ( this plugin should add async
" support hopefully soon )
Plug 'ctrlpvim/ctrlp.vim'
" CtrlP extension for fuzzy-search in tag matches
Plug 'ivalkeen/vim-ctrlp-tjump'
" Multiple cursors and selection support ( review need for this plugin later,
" since I don't really use it often )
"Plug 'terryma/vim-multiple-cursors'
" A Vim plugin that manages your tag files
Plug 'ludovicchabant/vim-gutentags'
" Helps you win at grep. ( does really work as expected, review later )
"Plug 'mhinz/vim-grepper', { 'commit': 'de4ab1864e6e381ba73c0f3badf31ce302e15e5e' }
Plug 'mhinz/vim-grepper'
" Snippets files for various programming languages
Plug 'honza/vim-snippets'
" The ultimate snippet solution for Vim ( these are quite slow, look for
" alternative in the futuer )
Plug 'SirVer/ultisnips'
" Better Diff options for Vim
Plug 'chrisbra/vim-diff-enhanced'
" Open a Quickfix item in a window you choose.
Plug 'yssl/QFEnter'
" A plugin for asynchronous :make using Neovim's job-control functionality
"Plug 'neomake/neomake'
" Asynchronous Lint Engine
Plug 'w0rp/ale'
" Dark powered asynchronous completion framework for neovim/Vim8
"Plug 'Shougo/deoplete.nvim'
"Plug 'roxma/nvim-yarp'
"Plug 'roxma/vim-hug-neovim-rpc'
"Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next' }
"Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" ============
" Text Objects
" ============
" Create your own text objects
Plug 'kana/vim-textobj-user'

"" ===========
"" Git support
"" ===========
" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'
" A Vim plugin which shows a git diff in the gutter (sign column) and stages/reverts hunks
Plug 'airblade/vim-gitgutter'
" Fugitive extension to manage and merge Git branches
Plug 'idanarye/vim-merginal'
" A git commit browser
Plug 'junegunn/gv.vim'

" ===================
" Syntax and languages
" ===================

" HTML/CSS

" Provides support for expanding abbreviations similar
Plug 'mattn/emmet-vim'
" HTML5 + inline SVG omnicomplete function, indent and syntax for Vim
Plug 'othree/html5.vim'
" Vim syntax file for scss (Sassy CSS)
Plug 'cakebaker/scss-syntax.vim'
" Add CSS3 syntax support to vim's built-in `syntax/css.vim` ( disable this
" plugin for now, it slows down opening of html files )
"Plug 'hail2u/vim-css3-syntax'
" Highlight colors in css files ( this plugin causes slight lag on scroll )
Plug 'ap/vim-css-color'
Plug 'digitaltoad/vim-pug'

" Javascript

" Vastly improved Javascript indentation and syntax support in Vim
Plug 'pangloss/vim-javascript'
" Enhanced javascript syntax file for Vim ( switch to this plugin if yajs is
" slow )
Plug 'jelera/vim-javascript-syntax'
" Syntax for JavaScript libraries
Plug 'othree/javascript-libraries-syntax.vim'
" Tools and environment to make Vim superb for developing with Node.js
Plug 'moll/vim-node'
" Typescript syntax files for Vim
Plug 'leafgarland/typescript-vim'
" List of JavaScript ES6 snippets and syntax highlighting for vim
Plug 'isRuslan/vim-es6'
" Generate JSDoc to your JavaScript code
Plug 'heavenshell/vim-jsdoc'
" AngularJS with Vim
Plug 'burnettk/vim-angular'

" Ruby

" Vim/Ruby Configuration Files
Plug 'vim-ruby/vim-ruby'
" Ruby on Rails power tools ( this plugin quite slows down the editor, load it
" only for ruby files. And consider removing it completely in the future )
Plug 'tpope/vim-rails', { 'for': ['ruby'] }
" Wisely add 'end' in ruby, endfunction/endif/more
Plug 'tpope/vim-endwise'
" Better rspec syntax highlighting for Vim
Plug 'keith/rspec.vim'

" Misc

" Make vim more Puppet friendly
Plug 'rodjek/vim-puppet'
" CoffeeScript support for vim
Plug 'kchmck/vim-coffee-script'
" Locally managed eclim
if g:eclim_supported
    "Plug g:plug_home . '/eclim'
endif

augroup load_on_insert
    autocmd!
    autocmd InsertEnter * call plug#load()
                \| autocmd! load_on_insert
augroup END
call plug#end()
