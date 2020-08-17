" This configuration file contains settings for
" previously used plugins


" =====================
" Plugins configuration {
" =====================

"" Airline
"let g:airline_powerline_fonts = 1
"let g:airline_theme = "airlineish"
"let g:airline_theme_patch_func = 'AirlineThemePatch'
"function! AirlineThemePatch(palette)
  "if g:airline_theme == 'airlineish'
    "" change inactive line background color
    "let s:IA = [ '#eeeeee' , '#4F5A5C' , 233 , 67 , '' ]
    "let a:palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)

    "" Change tabline colors
    "let g:airline#themes#airlineish#palette.tabline = {
                "\ 'airline_tab':     [ '#ffffff' , '#423B52' ,  15 , 200  , '' ],
                "\ 'airline_tabsel':  [ '#ffffff' , '#875fd7' ,  15 , 98  , '' ],
                "\ 'airline_tabtype': [ '#ffffff' , '#875fd7' ,  15 , 98  , '' ],
                "\ 'airline_tabfill': [ '#ffffff' , '#121212' ,  15 , 233 , '' ],
                "\ 'airline_tabmod':  [ '#ffffff' , '#ff5f5f' ,  15 , 33  , '' ]
                "\ }
  "endif
"endfunction
"" Enable airline tabline for better tabs
""let g:airline#extensions#tabline#enabled = 1
"" Show number of splits and tab number
"let g:airline#extensions#tabline#tab_nr_type = 2
"" Don't show buffers with a single tab
"let g:airline#extensions#tabline#show_buffers = 0
"" Display the tabline only if we have more than one tab
"let g:airline#extensions#tabline#tab_min_count = 2
"" Set some default mappings for navigation
"let g:airline#extensions#tabline#buffer_idx_mode = 1
"" Remove tabs label
"let g:airline#extensions#tabline#tabs_label = ''
"" Don't display close button. I never use it.
"let g:airline#extensions#tabline#show_close_button = 0
"" Don't show open splits within the tab
"let g:airline#extensions#tabline#show_splits = 0
"nmap <leader>1 <Plug>AirlineSelectTab1
"nmap <leader>2 <Plug>AirlineSelectTab2
"nmap <leader>3 <Plug>AirlineSelectTab3
"nmap <leader>4 <Plug>AirlineSelectTab4
"nmap <leader>5 <Plug>AirlineSelectTab5
"nmap <leader>6 <Plug>AirlineSelectTab6
"nmap <leader>7 <Plug>AirlineSelectTab7
"nmap <leader>8 <Plug>AirlineSelectTab8
"nmap <leader>9 <Plug>AirlineSelectTab9
"" Control extensions that are loaded on startup in order to make the load
"" faster
"let g:airline_extensions = ['tabline', 'ctrlp']



"" Syntastic
"" Suggested defaults
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"" disable it for now, since it slows down file opening significantly
"let g:syntastic_check_on_open = 0
"let g:syntastic_loc_list_height = 5
"let g:syntastic_mode_map = {
"    \ "mode": "active",
"    \ "passive_filetypes": ["java"] }
"" For now keep tsc falling back to tsconfig.json
"let g:syntastic_typescript_tsc_fname = ''
"
"" Make sure icons are enabled
""let g:syntastic_enable_signs = 1
""let g:syntastic_error_symbol='✗'
""let g:syntastic_warning_symbol='⚠'
"
" Easymotion
" Rebind easymotion to single leader
"let g:EasyMotion_smartcase = 1
"nmap s <Plug>(easymotion-s)
"nmap S <Plug>(easymotion-overwin-f)

"" Gundo
"nnoremap <Leader>u :GundoToggle<CR>
"" Make preview window a bit bigger
"let g:gundo_preview_height = 25
"" Refresh preview window manually (helps with gundo performance)
"let g:gundo_auto_preview = 0
"" Open Gundo tree on the right
"let g:gundo_right = 1
"" Close Gundo window when reverting
"let g:gundo_close_on_revert = 1
"
" Multiple Cursors
"let g:multi_cursor_use_default_mapping=0
"let g:multi_cursor_start_key = 'g<C-m>'
"let g:multi_cursor_start_word_key = '<C-m>'
"let g:multi_cursor_next_key='<C-m>'
"let g:multi_cursor_prev_key='<C-p>'
"let g:multi_cursor_skip_key='<C-x>'
"let g:multi_cursor_quit_key='<C-c>'


"
"" CtrlP Funky
"" Enable function search on ,cf
"nnoremap <leader>cf :CtrlPFunky<Cr>
"" Enable syntax highlighting in the ctrlp window
"let g:ctrlp_funky_syntax_highlight = 1
"" Include ruby class definitions
"let g:ctrlp_funky_ruby_classes = 1
"" Include ruby module definitions
"let g:ctrlp_funky_ruby_modules = 1
"" Include rspec definitions
"let g:ctrlp_funky_ruby_rspec = 1


"Ag (the_silver_searcher)
" bind \ (backward slash) to grep shortcut
"command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
"nnoremap <leader>g :LAg!<SPACE>
" bind K to grep word under cursor
"nnoremap K :LAg! <cword><CR>


" Vim-json
"let g:vim_json_syntax_conceal = 0


"" Autotag
"let g:autotagExcludeSuffixes = "tml.xml.text.txt.vim"
"


"" Tagbar
"nnoremap <silent> <leader>tb :TagbarToggle<CR>
"" Close tagbar when a tag is selected
"let g:tagbar_autoclose = 1
"" Bring cursor focus to tagbar automatically
"let g:tagbar_autofocus = 1


"" Indent guides
"" Set guides width to a narrow value
"let g:indent_guides_guide_size = 1
"let g:indent_guides_enable_on_vim_startup = 1
"" Disable guides for nerdtree
"let g:indent_guides_exclude_filetypes = ["help", "nerdtree"]


"" Follow My Lead
"" Show leader shortcuts from plugins as well
"let g:fml_all_sources = 1
"
"" Incsearch
"map / <Plug>(incsearch-forward)
"map ? <Plug>(incsearch-backward)
"map g/ <Plug>(incsearch-stay)
"" Enable automatic nohl
"let g:incsearch#auto_nohlsearch = 1
"map <silent> n  <Plug>(incsearch-nohl-n)zv:ShowSearchIndex<CR>
"map <silent> N  <Plug>(incsearch-nohl-N)zv:ShowSearchIndex<CR>
"map *  <Plug>(incsearch-nohl-*)
"map #  <Plug>(incsearch-nohl-#)
"map g* <Plug>(incsearch-nohl-g*)
"map g# <Plug>(incsearch-nohl-g#)
"" Make it play nicely with indexed-search
"let g:indexed_search_mappings = 0
"augroup incsearch-indexed
    "autocmd!
    "autocmd User IncSearchLeave ShowSearchIndex
"augroup END



"" Dispatch
"nnoremap <leader>ds :Dispatch<SPACE>
"nnoremap <leader>dS :Dispatch!<SPACE>
"nnoremap <leader>do :Copen<CR>
"
"" Followmylead
"" Default mapping for the plugin is <leader>fml
"" Collect mappings from all sources
"let g:fml_all_sources = 1
"
"" Argumentative
"" Just a list of provided bindings for reference
"" [, go to previous argument boundary
"" ], go to next argument boundary
"" <, shift current argument left
"" >, shift current argument right
"" a, 'an argument' text object
"" i, 'inner argument' text object
"
"" vim-test
"nmap <silent> <leader>tsn :TestNearest<CR>
"nmap <silent> <leader>tsf :TestFile<CR>
"nmap <silent> <leader>tsa :TestSuite<CR>
"nmap <silent> <leader>tsl :TestLast<CR>
"nmap <silent> <leader>tsv :TestVisit<CR>
"
"" Execute tests through dispatch
"let test#strategy = 'dispatch'
"
" Signature
" A list of useful mappings
" dmx remove mark 'x'
" m- delete all marks from the current line
" m<space> delete all marks from the current buffer
" m/ open location of all marks from the current buffer
" m<BS> remove all marks

"" Wildfire
"map <SPACE> <Plug>(wildfire-fuel)


" Targets
" Reference of the useful text objects and hints
" include 'n' to match the closest next object: cin)
" include 'l' to match the closest last object: cil)
" 'a' text object to match function arguments

"" Linediff
"xmap <leader>Ldf :Linediff<CR>
"xmap <leader>Ldr :LinediffReset<CR>
"nmap <leader>Ldr :LinediffReset<CR>
"
"" Windowswap
"" Use <leader>ww to mark a window to swap and then use the same mapping on
"" another window to swap the two
"
"
"" Ctrlp modified
"nnoremap <leader>cg :CtrlPBranch<CR>
"nnoremap <leader>cG :CtrlPModified<CR>
"
"" Argwrap
"nnoremap <silent> <leader>aw :ArgWrap<CR>

"" Markdown
"" Don't fold by default
"let g:vim_markdown_folding_disabled = 1

"" Jsx
"" Allow Jsx in javascript files
"let g:jsx_ext_required = 0
"

" Vim textobject rubyblock
" Reference text objects
" ir, ar target ruby block ( anything that has end )

"" Rubyrefactoring
"" Reference to useful mappings
"" ,rap add a parameter to method
"" ,rec extract constant
"" ,relv extract local variable
"" ,rit inline temp
"" ,rrlv rename local variable (visual or under cursor)
"" ,rriv rename instance variable(visual)
"" ,rem extract method (visual)
"
"" gitv
"" For the whole repository
"nnoremap <silent> <leader>GV :Gitv<CR>
"" For the current buffer only
"nnoremap <silent> <leader>Gv :Gitv!<CR>
"
"" Devicons
"" Reduce default padding in NERDtree
"let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
"" Required to remove dots in the icons. WTF???
"autocmd FileType nerdtree setlocal nolist
