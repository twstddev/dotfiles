" This file contains a list of plugins that
" previously were found useful, but for one or another reason
" are disabled for now. Come back and review them later


" Lean & mean status/tabline for vim that's light as air
"Plug 'paranoida/vim-airlineish'

"" Provides a much simpler way to use some motions
""Plug 'easymotion/vim-easymotion'
" A Vim plugin that always highlights the enclosing html/xml tags
"Plug 'Valloric/MatchTagAlways'
" Improved incremental searching for Vim
"Plug 'haya14busa/incsearch.vim'
" Lean & mean status/tabline for vim that's light as air
"Plug 'bling/vim-airline'
" A collection of themes for vim-airline
"Plug 'vim-airline/vim-airline-themes'
"" A syntax checking plugin
"Plugin 'scrooloose/syntastic'
"" A simple function navigator for ctrlp.vim
"Plugin 'tacahiroy/ctrlp-funky'
" A vim plugin to perform diffs on blocks of code
"Plug 'AndrewRadev/linediff.vim'
"" A plugin for visually displaying indent levels
"Plugin 'nathanaelkane/vim-indent-guides'
"" Plugin to visualize your Vim undo tree
"Plugin 'sjl/gundo.vim'
"" Plugin that simplifies the transition between multiline and single-line code
"Plugin 'AndrewRadev/splitjoin.vim'
"" Easy text exchange operator
"Plugin 'tommcdo/vim-exchange'
"" Vim plugin that displays tags in a window, ordered by scope
"Plugin 'majutsushi/tagbar'
"" Asynchronous build and test dispatcher
"Plugin 'tpope/vim-dispatch'
"" Smart selection of the closest text object
"Plugin 'gcmt/wildfire.vim'
"" Start a * or # search from a visual block
"Plugin 'nelstrom/vim-visual-star-search'
"" A Vim plugin for looking up documentation
"Plugin 'keith/investigate.vim'
"" Vim plugin for showing all your <Leader> mappings in a readable table
"" including the descriptions
"Plugin 'ktonga/vim-follow-my-lead'
"" Argumentative aids with manipulating and moving between function arguments
"Plugin 'PeterRincker/vim-argumentative'
"" Run your tests at the speed of thought
"Plugin 'janko-m/vim-test'
"" Swap your windows without ruining your layout
"Plugin 'wesQ3/vim-windowswap'
"" Easily open locally modified files in your git-versioned projects
"Plugin 'jasoncodes/ctrlp-modified.vim'
"" Wrap and unwrap function arguments, lists, and dictionaries in Vim
"Plugin 'FooSoft/vim-argwrap'
"" Projectionist provides granular project configuration using "projections".
"Plugin 'tpope/vim-projectionist'
"" Fast and Easy Find and Replace Across Multiple Files
"" Come back to it later and try to resolve the issue with Ag on windows, where
"" it doesn't recognize --ignore parameter
""Plugin 'dkprice/vim-easygrep'
"" Vim plugin for the_silver_searcher, 'ag'
"Plug 'rking/ag.vim'


" Text objects for indented blocks of lines
" ii, ai, iI, aI
"Plug 'kana/vim-textobj-indent'
" Text objects for functions
" if, af, iF, aF
"Plug 'kana/vim-textobj-function'


"" This is a vimscript for creating gists
""Plugin 'mattn/gist-vim'
"" A 'gitk clone' plugin for the text editor Vim
"Plugin 'gregsexton/gitv'
"" Vim Git runtime files
"Plugin 'tpope/vim-git'


" Vim syntax for LESS
"Plug 'groenewege/vim-less'


" YAJS.vim: Yet Another JavaScript Syntax for Vim ( watch performance of this
" plugin. readme says it tend to be slow )
"Plug 'othree/yajs.vim'
"" React JSX syntax highlighting and indenting for vim
"Plugin 'mxw/vim-jsx'
"" Jasmine Plugin for Vim
"Plugin 'claco/jasmine.vim'
"" Text objects for functions in javascript.
"Plugin 'thinca/vim-textobj-function-javascript'
"" Snippets files for AngularJS including JavaScript, HTML, CoffeeScript and HAML
"Plugin 'matthewsimo/angular-vim-snippets'
"" Various snippets for developing node.js from vim
"Plugin 'jamescarr/snipmate-nodejs'
"" Lightweight bag of Vim utilities for Backbone - snipmate snippets, templates and omnicompletion
"Plugin 'mklabs/vim-backbone'


" Ruby code completion
"Plug 'osyo-manga/vim-monster'
" This plugin allows rapid toggling between the two different styles of ruby blocks
"Plug 'jgdavey/vim-blockle'
" A custom text object for selecting ruby blocks
"Plug 'nelstrom/vim-textobj-rubyblock'
" Refactoring tool for Ruby in vim
"Plug 'ecomba/vim-ruby-refactoring'
"" Vim plugin that searches http://apidock.com Ruby, Rails, and RSpec docs from within Vim
"Plugin 'mileszs/apidock.vim'


" Vim Cucumber runtime files
"Plug 'tpope/vim-cucumber'
"" Maven syntax highlighting
"Plugin 'NLKNguyen/vim-maven-syntax'
" Syntax highlighting, matching rules and mappings for the original Markdown and extensions
"Plug 'plasticboy/vim-markdown'
" A better JSON for Vim ( Check for performance workarounds )
"Plug 'elzr/vim-json'
"" A vim plugin for working with mustache and handlebars templates
"Plugin 'mustache/vim-mustache-handlebars'
"" JSON manipulation and pretty printing
"Plugin 'tpope/vim-jdaddy'
"" Vim syntax highlighting for Jade templates
"Plugin 'digitaltoad/vim-jade'
"" Vim runtime files for Haml, Sass, and SCSS
"Plugin 'tpope/vim-haml'
"" Support for plantuml syntax
"Plugin 'aklt/plantuml-syntax'
"
"" Keep track of interesting plugins, which are not necessary at the moment
"" A quick notetaking plugin
""Plugin 'fmoralesc/vim-pad'
"" Execute URLs, footnotes, open emails, organize ideas
""Plugin 'vim-scripts/utl.vim'
"" A simple Vim plugin to switch segments of text with predefined replacements
""Plugin 'AndrewRadev/switch.vim'
"" Vim interface to Web API
""Plugin 'mattn/webapi-vim'
"" Better Rainbow Parentheses
""Plugin 'kien/rainbow_parentheses.vim'
"" Adds font icons (glyphs ★♨☢) to programming languages, libraries, and web
"" developer filetypes
"if !has('win32') && !has('win64')
"    "Plugin 'ryanoasis/vim-devicons'
"endif
"" Plugin for vim to enabling opening a file in a given line
""Plugin 'bogado/file-line'
"" Multi-language DBGP debugger client for Vim
"" Plugin 'joonty/vdebug'
"" Always have a nice view for vim split windows!
""Plugin 'zhaocai/GoldenView.Vim'
"" Vim plugin to dim inactive windows
""Plugin 'blueyed/vim-diminactive'
"" A powerful color tool in vim
""Plugin 'Rykka/colorv.vim'
"" Peekaboo extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers
""Plugin 'junegunn/vim-peekaboo'
"" Highlight cursor word
""Plugin 'osyo-manga/vim-brightest'
"" Extension for ctrlp.vim, to have a command palette like sublime text 2
""Plugin 'fisadev/vim-ctrlp-cmdpalette'
"" Easy text manupilation for vim
""Plugin 't9md/vim-textmanip'
