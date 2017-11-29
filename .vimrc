set nocompatible
let g:vimDir = $HOME.'/.vim'


" Plugins {{{
        packadd minpac
        call minpac#init()

        " minpac must have {'type': 'opt'} so that it can be loaded with `packadd`
        call minpac#add('k-takata/minpac', {'type': 'opt'})
        set packpath^=~/.vim

        call minpac#add('tpope/vim-unimpaired')
        call minpac#add('tpope/vim-sensible')        " sensible defaults
        call minpac#add('tpope/vim-surround')
        call minpac#add('tpope/vim-fugitive')
        call minpac#add('tpope/vim-repeat')
        call minpac#add('tpope/vim-commentary')
        call minpac#add('tpope/vim-surround')
        call minpac#add('junegunn/fzf')
        call minpac#add('junegunn/fzf.vim')         " Freakin fast fuzzy finder
        call minpac#add('junegunn/gv.vim')          " GV a git commit browser
        call minpac#add('junegunn/goyo.vim')        " Distraction free writing
        call minpac#add('junegunn/limelight.vim')   " Light my way
        call minpac#add('vimwiki/vimwiki')
        call minpac#add('airblade/vim-gitgutter')
        call minpac#add('itchyny/vim-cursorword')   " Underlines word under cursor
        call minpac#add('itchyny/lightline.vim')    " A lighter airline
        call minpac#add('itchyny/calendar.vim')     " Calendar w/Google Cal. integration
        call minpac#add('sjl/gundo.vim')            " Awesome undos
        call minpac#add('w0rp/ale')                 " Async linting engine
        call minpac#add('moll/vim-node')            " Async linting engine
        call minpac#add('ternjs/tern_for_vim')      " Code analysis engine
        call minpac#add('othree/javascript-libraries-syntax.vim')
        call minpac#add('othree/html5.vim')
        call minpac#add('elzr/vim-json')
        call minpac#add('cakebaker/scss-syntax.vim')
        call minpac#add('hail2u/vim-css3-syntax')
        call minpac#add('ap/vim-css-color')
        call minpac#add('plasticboy/vim-markdown')
        call minpac#add('vim-python/python-syntax')
        " call minpac#add('mattn/emmet-vim')          " Expand abbreviations
        " svermeulen/vim-easyclip
        " editorconfig-vim
" }}}

" Misc {{{

        let g:calendar_google_calendar = 1
        let g:calendar_google_task = 1
        
        let g:python_highlight_all = 1

" }}}

" Leader shortcuts {{{

        let mapleader = "\<Space>"       " Set mapleader to space
        " A better escape
        inoremap j; <esc>

        " toggle gundo
        nnoremap <leader>u :GundoToggle<CR>

        " save session
        nnoremap <leader>s :mksession<CR>

" }}}

" Spaces & Tabs {{{
        set tabstop=2		    " numger of visual spaces per tab
        set softtabstop=2	    " number of spaces in tab w/editing
        set expandtab       	" tabs are spaces
" }}}

" UI Layout {{{
        " Alot of inspiration from https://dougblack.io/words/a-good-vimrc.html

        set number		        " show line nu
        set showcmd             " show command in bottom bar
        set cursorline          " highlight current line
        set cursorline          " highlight current line
        set wildmenu            " visual autocomplete for command menu
        set lazyredraw          " redraw only when we need to
        set showmatch           " highlight matching [{()}]
        set incsearch           " search as characters are entered
        set hlsearch            " highlight matches

        " turn off search highlight FIND BETTER
        nnoremap <leader><space> :nohlsearch<CR>
        
        " Save and restore view
        autocmd BufWinLeave *.* mkview
        autocmd BufWinEnter *.* silent loadview 
        
        " automatic formatting on save
        autocmd bufwritepost *.js silent !standard --fix %
        set autoread
        
        " Goyo
        nnoremap <leader>g :Goyo<enter>
        
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

" }}}

" Folding {{{

        set foldenable          " enable folding
        set foldlevelstart=0	" open w folds closed
        set foldnestmax=10
        
        " space z to open/close folds
        nnoremap <leader>z za
        set foldmethod=indent
        
        let g:vimwiki_folding='list'

" }}}

" Shortcuts {{{
" }}}

" Colors {{{
        " colorscheme badwolf
        colorscheme solarized
        syntax enable

        let g:solarized_use16 = 1
        set background=light
        colorscheme solarized*_light

" }}}

" Movement {{{
        " move vertically by visual line
        nnoremap j gj
        nnoremap k gk

        " highlight last inserted text
        nnoremap gV `[v`]
        
        " switch tab
        nnoremap <S-right> :tabn<CR>
        nnoremap <S-left> :tabp<CR>
        
        set wrap
        set mouse=a
       
        " Delete inside parens
        onoremap p i(
        
" }}}

" Custom Functions {{{
        
        " toggle between number and relativenumber
        function! ToggleNum()
            if(&relativenumber == 1)
                set norelativenumber
                set number
            else
                set relativenumber
            endif
        endfunc

" }}}

" Commenting {{{
        
        command! PackUpdate call minpac#update()
        command! PackClean call minpac#clean()

        filetype plugin on
        syntax on

" }}}

" Autogroups {{{

        augroup configgroup
            autocmd!
            autocmd VimEnter * highlight clear SignColumn
            autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
                        \:call <SID>StripTrailingWhitespaces()
            autocmd FileType java setlocal noexpandtab
            autocmd FileType java setlocal list
            autocmd FileType java setlocal listchars=tab:+\ ,eol:-
            autocmd FileType java setlocal formatprg=par\ -w80\ -T4
            autocmd FileType php setlocal expandtab
            autocmd FileType php setlocal list
            autocmd FileType php setlocal listchars=tab:+\ ,eol:-
            autocmd FileType php setlocal formatprg=par\ -w80\ -T4
            autocmd FileType ruby setlocal tabstop=2
            autocmd FileType ruby setlocal shiftwidth=2
            autocmd FileType ruby setlocal softtabstop=2
            autocmd FileType ruby setlocal commentstring=#\ %s
            autocmd FileType python setlocal commentstring=#\ %s
            autocmd BufEnter *.cls setlocal filetype=java
            autocmd BufEnter *.zsh-theme setlocal filetype=zsh
            autocmd BufEnter Makefile setlocal noexpandtab
            autocmd BufEnter *.sh setlocal tabstop=2
            autocmd BufEnter *.sh setlocal shiftwidth=2
            autocmd BufEnter *.sh setlocal softtabstop=2
        augroup END

" }}}

" Spellingz {{{

        nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
        nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
        iabbrev waht what
        iabbrev tehn then
        iabbrev adn and
        iabbrev ssig -- <cr>Greg Johns<cr>

        set spelllang=en_us
        set nospell
" }}}

" VimWiki {{{

        let g:vimwiki_list = [{'path': '~/Documents/wiki/', 'syntax': 'markdown', 'ext': '.md'}]

" }}}


" check final line for vim modeline
set modelines=1

" vim:foldmethod=marker:foldlevel=0:tabstop=2
