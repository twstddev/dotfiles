" NERDTree
" Enable on Ctrl + N
map <C-n> :NERDTreeToggle<CR>
" Change current directory to the chosen root directory in NERDTree
let g:NERDTreeChDirMode = 2
" Show the bookmarks tree on startup
let NERDTreeShowBookmarks = 1
" Always delete buffer for removed file
let NERDTreeAutoDeleteBuffer = 1

" CtrlP
" Set searching from current pwd
let g:ctrlp_working_path_mode = 'rw'
" Don't jump to already open window
let g:ctrlp_switch_buffer = 0
" Add funky extensions
let g:ctrlp_extensions = ['funky','tag','buffertag','changes']
" Files that represent a project root
let g:ctrlp_root_markers = [".project"]
" Create shortcuts for ctrlp helpers
nnoremap <leader>cB :CtrlPBuffer<Cr>
nnoremap <leader>cr :CtrlPMRU<Cr>
nnoremap <leader>cT :CtrlPTag<Cr>
nnoremap <leader>ct :CtrlPBufTag<Cr>
nnoremap <leader>cC :CtrlPChange<Cr>
let g:ctrlp_map = '<c-t>'

" Ag (the_silver_searcher)
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects
    " .gitignore
    let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s '

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

"if executable('ripgrep')
    "let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    "let g:ctrlp_use_caching = 0
"endif

" UltiSnips
let g:UltiSnipsEnableSnipMate = 1
let g:UltiSnipsExpandTrigger = "<c-j>"
" Disable track changes, it just another performance hit
"au! UltiSnips_AutoTrigger

" Emmet
imap <C-e> <C-y>,

" Vim-javascript
"Enable HTML/CSS highlighting in JS
let g:javascript_enable_domhtmlcss=1

" Vim-javascript-libraries-syntax
let g:used_javascript_libs = 'underscore,backbone,angularjs,react,jasmine,chai,angularui,angularuirouter,requirejs,flux,jquery'

" Gitgutter
let g:gitgutter_map_keys = 0
" Realtime mode causes to many cmd popups on windows. Let's just disable it
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" Surround
" Wrap the token under the cursor in #{} ( use # )
let g:surround_35 = "#{\r}"
" Wrap the token under the cursor in <% %> ( use % )
let g:surround_37 = "<% \r %>"
" Wrap the token under the cursor in <%= %> ( use = )
let g:surround_61 = "<%= \r %>"

" Fugitive
" Mappings
nnoremap <silent> <leader>Gs :Gstatus<CR>
nnoremap <silent> <leader>Gd :Gdiff<CR>
nnoremap <silent> <leader>Gc :Gcommit<CR>
nnoremap <silent> <leader>Gb :Gblame<CR>
nnoremap <silent> <leader>Gl :Glog<CR>
nnoremap <silent> <leader>GL :Gpull<CR>
nnoremap <silent> <leader>Gp :Gpush<CR>
nnoremap <silent> <leader>Gr :Gread<CR>
nnoremap <silent> <leader>Gw :Gwrite<CR>
nnoremap <silent> <leader>Ge :Gedit<CR>

" Delimitmate
" Expand Spaces
let g:delimitMate_expand_space = 1
" Expand Enters
let g:delimitMate_expand_cr = 1

if g:eclim_supported
    " Eclim
    " Play nicely with YouCompleteMe
    let g:EclimCompletionMethod = 'omnifunc'
    " Update eclipse local history for better experience while pairing with Java programmers who use Eclipse
    let g:EclimKeepLocalHistory = 1
    " Disable menu items since it slows down opening buffers
    let g:EclimMenus = 0
    " Disable validation for anything but Java
    let g:JavascriptValidate = 0
    let g:CssValidate = 0
    let g:DtdValidate = 0
    let g:HtmlValidate = 0
    let g:XmlValidate = 0
    let g:XsdValidate = 0

    " Useful mappings
    nnoremap <leader>epr :ProjectRefresh<CR>
    nnoremap <leader>epR :ProjectRefreshAll<CR>
    " List current project warnings and errors
    nnoremap <leader>epP :ProjectProblems<CR>
    " List only project errors
    nnoremap <leader>epp :ProjectProblems!<CR>
    " Build current Eclipse project
    nnoremap <leader>epb :ProjectBuild<CR>
    " Run current Eclipse project
    nnoremap <leader>epx :ProjectRun<CR>
    " Show list of run configurations for the current project
    nnoremap <leader>epX :ProjectRunList<CR>
    " Display suggestions for the currently highlighted error
    nnoremap <leader>ejC :JavaCorrect<CR>
    " Create or update JavaDoc comment
    nnoremap <leader>ejdc :JavaDocComment<CR>
    " Preview JavaDoc for the word under cursor
    nnoremap <leader>ejdp :JavaDocPreview<CR>
    " Format current line or selection, to format the whole file do :%JavaFormat
    nnoremap <leader>ejf :JavaFormat<CR>
    " Rename symbol under cursor
    nnoremap <leader>ejrr :JavaRename<SPACE>
    " Move top level class or interface
    nnoremap <leader>ejrm :JavaMove<SPACE>
    " Undo refactoring changes
    nnoremap <leader>ejru :RefactorUndo<CR>
    " Show class hierarchy
    nnoremap <leader>ejh :JavaHierarchy<CR>
    " Show call hierarchy
    nnoremap <leader>ejch :JavaCallHierarchy<CR>
    " Show call hierarchy with calees
    nnoremap <leader>ejcH :JavaCallHierarchy!<CR>
    " Import package for the symbol under cursor
    nnoremap <leader>eji :JavaImport<CR>
    " Organize all imports
    nnoremap <leader>ejI :JavaImportOrganize<CR>
    " Create new Generic
    nnoremap <leader>ejN :JavaNew<SPACE>
    " Create new Class
    nnoremap <leader>ejnc :JavaNew class<SPACE>
    " Create new Interface
    nnoremap <leader>ejni :JavaNew interface<SPACE>
    " Create new Abstract
    nnoremap <leader>ejna :JavaNew abstract<SPACE>
    " Create new Enum
    nnoremap <leader>ejne :JavaNew enum<SPACE>
    " Generate constructor. As well works with selection that covers class fields
    nnoremap <leader>ejgc :JavaConstructor<CR>
    xnoremap <leader>ejgc :JavaConstructor<CR>
    " Generate getter and setter for the field under cursor
    nnoremap <leader>ejga :JavaGetSet<CR>
    " Generate getter for the field under cursor
    nnoremap <leader>ejgg :JavaGet<CR>
    " Generate setter for the field under cursor
    nnoremap <leader>ejgs :JavaSet<CR>
    " Generate implementation
    nnoremap <leader>ejgi :JavaImpl<CR>
    " Generate delegate
    nnoremap <leader>ejgd :JavaDelegate<CR>
    " Perform a generic Java Search
    nnoremap <leader>ejS :JavaSearch -p<space>
    " Perform generic search for the symbol under cursor
    nnoremap <leader>ejsa :JavaSearch -x all<CR>
    " Search for declaration
    nnoremap <leader>ejsd :JavaSearch -x declaration<CR>
    " Search for implementation
    nnoremap <leader>ejsi :JavaSearch -x implementors<CR>
    " Search for references
    nnoremap <leader>ejsr :JavaSearch -x references<CR>
endif

" Matchit
let b:match_ignorecase = 1

" Tabularize
nmap <leader>ta :Tabularize /
vmap <leader>ta :Tabularize /

" Gutentags
"set statusline+=%{gutentags#statusline('[Generating\ tags]')}
let g:gutentags_project_root = [".gtags"]
" choose for which projects to generate tags
let g:gutentags_add_default_project_roots = 0
" By some reason on windows ctags ignore wildcard
let g:gutentags_ctags_exclude = ["*.min.js"]

set completeopt-=preview

if g:ycm_supported
    " Youcompleteme
    " Display suggestions on first character
    let g:ycm_min_num_of_chars_for_completion = 1
    " Collect information from tags as well
    let g:ycm_collect_identifiers_from_tags_files = 1
    " Collect information from the programming language syntax keywords known to
    " vim
    let g:ycm_seed_identifiers_with_syntax = 1
    " Make others onmicompletion engines work better with YCM
    " Have to keep it enabled for now, since the performance with eclim is just
    " way too bad
    let g:ycm_cache_omnifunc = 1
    " Goto within the same buffer
    let g:ycm_goto_buffer_command = 'same-buffer'
    " Turn off ultisnips querying, because it causes lag when buffers are opened or
    " switched ( as well don't forget to patch youcompleteme.py and remote call to
    " _AddUltiSnipsDataIfNeeded. this are just insanely slow and useless )
    let g:ycm_use_ultisnips_completer = 0
    " Configure shortcuts
    nnoremap <leader>Jg :YcmCompleter GoTo<CR>
    nnoremap <leader>Jdc :YcmCompleter GoToDeclaration<CR>
    nnoremap <leader>Jdf :YcmCompleter GoToDefinition<CR>
    nnoremap <leader>Jr :YcmCompleter GoToReferences<CR>
    nnoremap <leader>Ji :YcmCompleter GoToImplementation<CR>
    nnoremap <leader>Jt :YcmCompleter GetType<CR>
    nnoremap <leader>Jp :YcmCompleter GetParent<CR>
    nnoremap <leader>JD :YcmCompleter GetDoc<CR>
    nnoremap <leader>JR :YcmCompleter RefactorRename<SPACE>
    nnoremap <leader>Ju :YcmCompleter RestartServer<CR>

    " Enable omnicomplete for various languages
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
endif

"Yankring
let g:yankring_history_dir = "~/.vim/history"
let g:yankring_history_file = "yank"
let g:yankring_max_history = 25
let g:yankring_replace_n_pkey = "<leader>yj"
let g:yankring_replace_n_nkey = "<leader>yk"
nnoremap <silent> <leader>ys :YRShow<CR>
" just in case for console vim
nnoremap <silent> <leader>yc :YRCheckClipboard<CR>

" Limelight
" Dim unfocused text
let g:limelight_default_coefficient = 0.75
nmap <leader>LL :Limelight!!<CR>
" Focus on selection
nmap <Leader>Lf <Plug>(Limelight)
xmap <Leader>Lf <Plug>(Limelight)

" Targets
" Reference of the useful text objects and hints
" include 'n' to match the closest next object: cin)
" include 'l' to match the closest last object: cil)
" 'a' text object to match function arguments

" Goyo
nnoremap <leader>Go :Goyo<CR>
let g:goyo_width = '60%'

" Rooter
let g:rooter_patterns = ['.tern-project', 'Gemfile', '.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/']
let g:rooter_change_directory_for_non_project_files = 1
" Stop echoing project directory
let g:rooter_silent_chdir = 1

" Pasta
let g:pasta_disabled_filetypes = ["python", "coffee", "markdown", "yaml", "slim", "nerdtree", "tagbar"]

" Ctrlp tjump
nnoremap <c-]> :CtrlPtjump<cr>
vnoremap <c-]> :CtrlPtjumpVisual<cr>
" Behave as the default shortcut by default
let g:ctrlp_tjump_only_silent = 1

" Jsdoc
nnoremap <leader>Jsd :JsDoc<CR>

" Vim-ruby
" Reference of text objects
" am, im target method
" aM, iM target class
" Hihglight ruby operators
let ruby_operators = 1
" Enable ruby completion
let g:rubycomplete_buffer_loading = 1
" Parse classes and methods
let g:rubycomplete_classes_in_global = 3
" Enable rails completion
let g:rubycomplete_rails = 1
" Parse gemfile too
let g:rubycomplete_load_gemfile = 1

" Rails
" Display development logs
nnoremap <leader>ral :Rlog<CR>
" Extract part of view->partial, helper->helper or controller -> concern
" Provide a name
nnoremap <leader>rax :Rextract<space>

" Sneak
" read case sensitivity property from the main settings
let g:sneak#use_ic_scs = 1
" Enforce streak mode
let g:sneak#streak = 1
nmap s <Plug>(SneakStreak)
nmap S <Plug>(SneakStreakBackward)

" Grepper
nnoremap <silent> <leader>g :Grepper<cr>
nnoremap K :Grepper -tool ag -cword -noprompt<cr>
let g:grepper = {
        \'tools': ['ag', 'git', 'grep']
        \}

" Lightline
let g:lightline = {
        \ 'colorscheme': 'Tomorrow_Night_Eighties',
        \ 'separator': { 'left': '', 'right': ''  },
        \ 'subseparator': { 'left': '', 'right': ''  },
        \ 'active': {
            \ 'left': [ [ 'mode', 'paste' ],
            \           [ 'readonly', 'filename', 'modified' ],
            \           [ 'ctrlp' ] ],
            \ 'right': [ [ 'lineinfo' ],
            \            [ 'percent' ],
            \            [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'component_expand': {
            \ 'ctrlp': 'CtrlpStatus'
        \ },
        \ 'component_type': {
            \ 'ctrlp': 'warning'
        \ }
        \ }

" function that returns display info for ctrlp plugin
function! CtrlpStatus()
    if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
        return [g:lightline.ctrlp_prev, g:lightline.ctrlp_item, g:lightline.ctrlp_next]
    else
        return [' ']
    endif
endfunction

" hooks called by ctrlp i assume???
let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

" Neomake
"autocmd! BufWritePost * Neomake
" Disable checker for java, use eclim instead
let g:neomake_java_enabled_makers = []
" Open errors list but keep cursor position
let g:neomake_open_list = 2
let g:neomake_typescript_enabled_makers = ['tslint', 'tsc']

" json plugin
let g:vim_json_syntax_conceal = 0

" Ale
let g:ale_linters = { 'java': [] }
let g:ale_list_window_size = 4
let g:ale_lint_on_text_changed = 'never'
let g:ale_open_list = 1
let g:ale_lint_on_insert_leave = 0

" Deoplete
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#complete_method = 'omnifunc'
"let g:deoplete#auto_complete_delay = 0


" Use Tab to navigate through completions
"inoremap <expr><Tab>  pumvisible() ?   "\<C-n>"  : "\<Tab>"
"inoremap <expr><S-Tab>    pumvisible() ?   "\<C-p>"  : "\<S-Tab>"

" Force completion on ctrl space
"inoremap <silent><expr> <C-Space>
            "\ pumvisible() ? "\<C-n>" :
            "\ <SID>check_back_space() ? "\<C-Space>" :
            "\ deoplete#mappings#manual_complete()

"function! s:check_back_space() abort
    "let col = col('.') - 1
    "return !col || getline('.')[col - 1]  =~ '\s'
"endfunction

" Start completing at first character
let g:deoplete#auto_complete_start_length = 1
"let g:deoplete#enable_refresh_always = 1
"let g:deoplete#omni#functions = {}
"let g:deoplete#omni#functions.typescript = 'lsp#complete'
"let g:deoplete#omni#functions.java = 'lsp#complete'

" Lsp
if executable('javascript-typescript-stdio')
   au User lsp_setup call lsp#register_server({
        \ 'name': 'javascript-typescript-stdio',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'javascript-typescript-stdio']},
        \ 'whitelist': ['typescript'],
        \ })
endif

if executable('jdtls')
   au User lsp_setup call lsp#register_server({
        \ 'name': 'jdtls',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'jdtls']},
        \ 'whitelist': ['java'],
        \ })
endif

" Language Client
let g:LanguageClient_diagnosticsEnable = 0

" Configure shortcuts
"nnoremap <leader>Jt :call LanguageClient_textDocument_hover()<CR>
"nnoremap <leader>Jdf :call LanguageClient_textDocument_definition()<CR>
"nnoremap <leader>JR :call LanguageClient_textDocument_rename()<CR>
"nnoremap <leader>JD :call LanguageClient_textDocument_documentSymbol()<CR>
"nnoremap <leader>Jr :call LanguageClient_textDocument_references()<CR> :lopen <CR>

" Configure completions for languages
let g:LanguageClient_serverCommands = {}

let g:LanguageClient_serverCommands.typescript = ['javascript-typescript-stdio']
"autocmd FileType typescript setlocal omnifunc=LanguageClient#complete
"autocmd FileType typescript setlocal omnifunc=lsp#complete

let g:LanguageClient_serverCommands.java = ['jdtls']
"autocmd FileType java setlocal omnifunc=LanguageClient#complete
"autocmd FileType java setlocal omnifunc=lsp#complete

"let g:LanguageClient_serverCommands.ruby = ['language_server-ruby']
"autocmd FileType ruby setlocal omnifunc=LanguageClient#complete

"let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
"autocmd FileType javascript setlocal omnifunc=LanguageClient#complete

" FZF
"let $FZF_DEFAULT_COMMAND = 'rg --smart-case --files --hidden --follow --line-number --no-heading --glob "!.git/*"'
let $FZF_DEFAULT_COMMAND = 'rg --no-messages --smart-case --files --hidden --glob "!.git/*"'
let g:fzf_layout = { 'down': '~20%' }
nnoremap <c-p> :Files<CR>
nnoremap <leader>cL :BLines<CR>
nnoremap <leader>cS :Snippets<CR>