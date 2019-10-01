scriptencoding utf-8
source ~/.config/nvim/plugins.vim

" ============================================================================ "
" ===                           EDITING OPTIONS                            === "
" ============================================================================ "

" General options {{{
  let mapleader="\<Space>"

  " Disable line numbers
  set nonumber

  " Don't show last command
  set noshowcmd

  " Yank and paste with the system clipboard
  set clipboard=unnamed

  " Hides buffers instead of closing them
  set hidden
" }}}

" TAB/Space settings {{{
  set expandtab               " Insert spaces when TAB is pressed.
  set softtabstop=2           " Change number of spaces that a <Tab> counts for during editing ops
  set shiftwidth=2            " Indentation amount for < and > commands.
  set nowrap                  " do not wrap long lines by default
  set nocursorline            " Don't highlight current cursor line
  " Disable line/column number in status line
  " Shows up in preview window when airline is disabled if not
  set noruler

  " Only one line for command line
  set cmdheight=1
  " switch tab
  nnoremap <S-right> :tabn<CR>
  nnoremap <S-left> :tabp<CR>
" }}}

" Completion settings {{{
  " Don't give completion messages like 'match 1 of 2'
  set shortmess+=c
" }}}

" ============================================================================ "
" ===                           PLUGIN SETUP                               === "
" ============================================================================ "
  " Wrap in try/catch to avoid errors on initial install before plugin is available
  try
  " === Denite setup ==="
  " Use ripgrep for searching current directory for files
  " By default, ripgrep will respect rules in .gitignore
  "   --files: Print each file that would be searched (but don't search)
  "   --glob:  Include or exclues files for searching that match the given glob
  "            (aka ignore .git files)
  "
  call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

  " Use ripgrep in place of "grep"
  call denite#custom#var('grep', 'command', ['rg'])

  " Custom options for ripgrep
  "   --vimgrep:  Show results with every match on it's own line
  "   --hidden:   Search hidden directories and files
  "   --heading:  Show the file name above clusters of matches from each file
  "   --S:        Search case insensitively if the pattern is all lowercase
  call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

  " Recommended defaults for ripgrep via Denite docs
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])

  " Remove date from buffer list
  call denite#custom#var('buffer', 'date_format', '')

  " Open file commands
  call denite#custom#map('insert,normal', "<C-t>", '<denite:do_action:tabopen>')
  call denite#custom#map('insert,normal', "<C-v>", '<denite:do_action:vsplit>')
  call denite#custom#map('insert,normal', "<C-h>", '<denite:do_action:split>')

  " Custom options for Denite
  "   auto_resize             - Auto resize the Denite window height automatically.
  "   prompt                  - Customize denite prompt
  "   direction               - Specify Denite window direction as directly below current pane
  "   winminheight            - Specify min height for Denite window
  "   highlight_mode_insert   - Specify h1-CursorLine in insert mode
  "   prompt_highlight        - Specify color of prompt
  "   highlight_matched_char  - Matched characters highlight
  "   highlight_matched_range - matched range highlight
  let s:denite_options = {'default' : {
  \ 'split': 'floating',
  \ 'start_filter': 1,
  \ 'auto_resize': 1,
  \ 'source_names': 'short',
  \ 'prompt': 'λ:',
  \ 'statusline': 0,
  \ 'highlight_matched_char': 'WildMenu',
  \ 'highlight_filter_background': 'StatusLine',
  \ 'highlight_prompt': 'StatusLine',
  \ 'winrow': 1,
  \ 'vertical_preview': 1
  \ }}

  " Loop through denite options and enable them
  function! s:profile(opts) abort
    for l:fname in keys(a:opts)
      for l:dopt in keys(a:opts[l:fname])
        call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
      endfor
    endfor
  endfunction

  call s:profile(s:denite_options)
  catch
    echo 'Denite not installed. It should work after running :PlugInstall'
  endtry
" }}}

" === Signify === "
let g:signify_sign_delete = '-'

" Snippets {{{
  " Map <C-k> as shortcut to activate snippet if available
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)

  " Load custom snippets from snippets folder
  let g:neosnippet#snippets_directory='~/.config/nvim/snippets'

  " Hide conceal markers
  let g:neosnippet#enable_conceal_markers = 0
" }}}

" Lauguage Server {{{
  set hidden
  let g:LanguageClient_useFloatingHover=1
  let g:LanguageClient_hoverPreview='Always'
  let g:LanguageClient_diagnosticsDisplay = {
        \   1: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
        \   2: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
        \   3: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
        \   4: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
        \ }
  let g:LanguageClient_rootMarkers = {
        \   'javascript': ['tsconfig.json', '.flowconfig', 'package.json'],
        \   'typescript': ['tsconfig.json', '.flowconfig', 'package.json']
        \ }
  let g:LanguageClient_serverCommands = {}

  if exists('$DEBUG_LC_LOGFILE')
    let g:LanguageClient_loggingFile=$DEBUG_LC_LOGFILE
    let g:LanguageClient_loggingLevel='DEBUG'
  endif

  if executable('typescript-language-server')
    " ie. via `npm install -g typescript-language-server`
    if exists('$DEBUG_LSP_LOGFILE')
      let s:debug_args=[
            \   '--log-level=4',
            \   '--tsserver-log-file',
            \   $DEBUG_LSP_LOGFILE,
            \   '--tsserver-log-verbosity=verbose'
            \ ]
    else
      let s:debug_args=[]
    endif

  " INSTALL JS-TS-ST
    let s:ts_lsp=extend([exepath('javascript-typescript-stdio')], s:debug_args)
  elseif executable('javascript-typescript-stdio')
    " ie. via `npm install -g javascript-typescript-langserver`
    if exists('$DEBUG_LSP_LOGFILE')
      let s:debug_args=['--trace', '--logfile', $DEBUG_LSP_LOGFILE]
    else
      let s:debug_args=[]
    endif

    let s:ts_lsp=extend([exepath('javascript-typescript-stdio')], s:debug_args)
  else
    let s:ts_lsp=[]
  endif

  " From `npm install -g flow-bin`:
  let s:flow_lsp=executable('flow') ?
        \ [exepath('flow'), 'lsp'] :
        \ []

  let s:ts_filetypes=[
        \   'typescript',
        \   'typescript.tsx',
        \   'typescript.jest',
        \   'typescript.jest.tsx'
        \ ]

  let s:js_filetypes=[
        \   'javascript',
        \   'javascript.jsx',
        \   'javascript.jest',
        \   'javascript.jest.jsx'
        \ ]

  if s:ts_lsp != []
    for s:ts_filetype in s:ts_filetypes
      let g:LanguageClient_serverCommands[s:ts_filetype]=s:ts_lsp
    endfor
  endif

  if s:ts_lsp != [] && filereadable('tsconfig.json')
    let s:js_lsp=s:ts_lsp
  elseif s:flow_lsp != [] && filereadable('.flowconfig')
    let s:js_lsp=s:flow_lsp
  elseif s:ts_lsp != []
    let s:js_lsp=s:ts_lsp
  endif

  if exists('s:js_lsp')
    for s:js_filetype in s:js_filetypes
      let g:LanguageClient_serverCommands[s:js_filetype]=s:js_lsp
    endfor
  endif

  " if executable('ocaml-language-server')
  "   let s:ocaml_lsp=[exepath('ocaml-language-server')]
  "   let g:LanguageClient_serverCommands['reason']=s:ocaml_lsp
  "   let g:LanguageClient_serverCommands['ocaml']=s:ocaml_lsp
  " endif

  " let g:LanguageClient_serverCommands = {
  "   \ 'reason': ['/Users/foo/Projects/Reason/rls-macros/reason-language-server'],
  "   \ }
  " let g:LanguageClient_serverCommands = {
  "   \ 'reason': ['/Users/foo/Projects/Reason/rls-macros/reason-language-server'],
  "   \ 'javascript': ['/User/foo/Projects/javascript-typescript-stdio'],
  "   \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
  "   \ 'typescript': ['tcp://127.0.0.1:2089'],
  "   \ 'typescript.tsx': ['tcp://127.0.0.1:2089']
  "   \ }
  let g:deoplete#ernable_at_startup = 1
  nnoremap <silent> gd :call LanguageClient#textDocument_definition()<cr>
  nnoremap <silent> gf :call LanguageClient#textDocument_formatting()<cr>
  nnoremap <silent> K :call LanguageClient#textDocument_hover()<cr>
" }}}

" NERDTree {{{
  " Show hidden files/directories
  let g:NERDTreeShowHidden = 1

  " Remove bookmarks and help text from NERDTree
  let g:NERDTreeMinimalUI = 1

  " Custom icons for expandable/expanded directories
  let g:NERDTreeDirArrowExpandable = '⬏'
  let g:NERDTreeDirArrowCollapsible = '⬎'

  " Hide certain files and directories from NERDTree
  let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']

  " Wrap in try/catch to avoid errors on initial install before plugin is available
  try
" }}}

" Airline {{{
  " Enable extensions
  let g:airline_extensions = ['branch', 'hunks', 'coc']

  " Update section z to just have line number
  let g:airline_section_z = airline#section#create(['linenr'])

  " Do not draw separators for empty sections (only for the active window) >
  let g:airline_skip_empty_sections = 1

  " Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
  let g:airline#extensions#tabline#formatter = 'unique_tail'

  " Custom setup that removes filetype/whitespace from default vim airline bar
  let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

  let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'

  let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

  " Configure error/warning section to use coc.nvim
  let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
  let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

  " Hide the Nerdtree status line to avoid clutter
  let g:NERDTreeStatusline = ''

  " Disable vim-airline in preview mode
  let g:airline_exclude_preview = 1

  " Enable powerline fonts
  let g:airline_powerline_fonts = 1

  " Enable caching of syntax highlighting groups
  let g:airline_highlighting_cache = 1

  " Define custom airline symbols
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.whitespace = 'Ξ'

  " airline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''

  " Don't show git changes to current file in airline
  let g:airline#extensions#hunks#enabled=0

  catch
    echo 'Airline not installed. It should work after running :PlugInstall'
  endtry
" }}}

" Echodoc {{{
  " Enable echodoc on startup
  let g:echodoc#enable_at_startup = 1
" }}}

" Javascript {{{
  " Enable syntax highlighting for JSDoc
  let g:javascript_plugin_jsdoc = 1

  " Highlight jsx syntax even in non .jsx files
  let g:jsx_ext_required = 0

  " Javascript-libraries-syntax
  let g:used_javascript_libs = 'underscore,requirejs,chai,jquery'
"}}}

" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "
" UI {{{
  " Colors {
      " Enable true color support
      set termguicolors

      " Editor theme
      set background=dark
      try
        colorscheme OceanicNext
      catch
        colorscheme slate
      endtry

      " Vim airline theme
      " let g:airline_theme='bubblegum'
      let g:airline_theme='understated'

      " Add custom highlights in method that is executed every time a
      " colorscheme is sourced
      " See https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f for
      " details
      function! MyHighlights() abort
        " Hightlight trailing whitespace
        highlight Trail ctermbg=red guibg=red
        call matchadd('Trail', '\s\+$', 100)
      endfunction

      augroup MyColors
        autocmd!
        autocmd ColorScheme * call MyHighlights()
      augroup END

      " coc.nvim color changes
      hi! link CocErrorSign WarningMsg
      hi! link CocWarningSign Number
      hi! link CocInfoSign Type
  " }

  " Splits {
    " Change vertical split character to be a space (essentially hide it)
    set fillchars+=vert:.

    " Set preview window to appear at bottom
    set splitbelow

    " Don't dispay mode in command line (airilne already shows it)
    set noshowmode

    " Set floating window to be slightly transparent
    set winbl=10
  " }

" Make background transparent for many things
" hi! Normal ctermbg=NONE guibg=NONE
" hi! NonText ctermbg=NONE guibg=NONE
" hi! LineNr ctermfg=NONE guibg=NONE
" hi! SignColumn ctermfg=NONE guibg=NONE
" hi! StatusLine guifg=#16252b guibg=#6699CC
" hi! StatusLineNC guifg=#16252b guibg=#16252b

" Make background color transparent for git changes
hi! SignifySignAdd guibg=NONE
hi! SignifySignDelete guibg=NONE
hi! SignifySignChange guibg=NONE

" Highlight git change signs
hi! SignifySignAdd guifg=#99c794
hi! SignifySignDelete guifg=#ec5f67
hi! SignifySignChange guifg=#c594c5

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of preview window when open
function! Handle_Win_Enter()
  if &previewwindow
    setlocal winhighlight=Normal:MarkdownError
  endif
endfunction

" Background colors for active vs inactive windows
hi ActiveWindow guibg=#0D1B22
hi InactiveWindow guibg=#17252c

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" === Signify === "
let g:signify_sign_delete = '-'

" Try to hide vertical spit and end of buffer symbol
hi! VertSplit gui=NONE guifg=#17252c guibg=#17252c
hi! EndOfBuffer ctermbg=NONE ctermfg=NONE guibg=#17252c guifg=#17252c

" Customize NERDTree directory
hi! NERDTreeCWD guifg=#99c794

" Change highlight group of active/inactive windows
function! Handle_Win_Enter()
  setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endfunction
" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap ; :Denite buffer<CR>
nmap <leader>t :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>
inoremap jj <esc>
" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
endfunction

" === Nerdtree shorcuts === "
"  <leader>n - Toggle NERDTree on/off
"  <leader>f - Opens current file location in NERDTree
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>

"   <Space> - PageDown
"   -       - PageUp
noremap _ <PageDown>
noremap - <PageUp>

" === coc.nvim === "
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)

" === vim-better-whitespace === "
"   <leader>y - Automatically remove trailing whitespace
nmap <leader>s :StripWhitespace<CR>

" === Search shorcuts === "
"   <leader>h - Find and replace
map <leader>h :%s///<left><left>
" <space><space> to de-highlight serch string
nmap <silent> <leader><leader> :nohlsearch<CR>

" === Easy-motion shortcuts ==="
"   <leader>w - Easy-motion highlights first word letters bi-directionally
map <leader>w <Plug>(easymotion-bd-w)

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

" === vim-jsdoc shortcuts ==="
" Generate jsdoc for function under cursor
nmap <leader>z :JsDoc<CR>

" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
vnoremap <leader>p "_dP

" Folding {{{
  set foldenable          " enable folding
  set foldlevelstart=0	" open w folds closed
  set foldnestmax=10

  " space z to open/close folds
  nnoremap <leader>z za
  set foldmethod=indent

  let g:vimwiki_folding='list'
" }}}

" Misc. {{{
  " Automaticaly close nvim if NERDTree is only thing left open
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  set ignorecase    " ignore case when searching
  set smartcase     " if the search string has an upper case letter in it, the search will be case sensitive

  set autoread      " Automatically re-read file if a change was detected outside of vim

  set number        " Enable line numbers

  " toggle gundo
  nnoremap <leader>u :GundoToggle<CR>

  set cursorline
  set lazyredraw

  " On save {
    " Save and restore view
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent loadview
    " format
    autocmd bufwritepost *.js silent !standard --fix %
    set autoread
    " save session
    nnoremap <leader>s :mksession<CR>
  " }

  " Goyo {
    nnoremap <leader>q :Goyo<enter>
    function! s:goyo_enter()
      set noshowmode
      set scrolloff=999
      Limelight
    endfunction

    function! s:goyo_leave()
      set showmode
      set scrolloff=5
      Limelight!
    endfunction

    autocmd! User GoyoEnter nested call <SID>goyo_enter()
    autocmd! User GoyoLeave nested call <SID>goyo_leave()
  " }

  " Set backups {
    if has('persistent_undo')
      set undofile
      set undolevels=3000
      set undoreload=10000
    endif
    set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
    set backup
    set noswapfile
  " }

  " Reload icons after init source {
    if exists('g:loaded_webdevicons')
      call webdevicons#refresh()
    endif
  " }
" }}
