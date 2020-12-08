" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "

" Setup Vim-Plug {{{
  " check whether vim-plug is installed and install it if necessary
  let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
  if !filereadable(plugpath)
      if executable('curl')
          let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
          call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
          if v:shell_error
              echom "Error downloading vim-plug. Please install it manually.\n"
              exit
          endif
      else
          echom "vim-plug not installed. Please install it manually or install curl.\n"
          exit
      endif
  endif

  call plug#begin('~/.config/nvim/plugged')
" }}}

" Editing {{{
  Plug 'rakr/vim-one'
  Plug 'mhinz/vim-startify'
  Plug 'ntpeters/vim-better-whitespace'       " Auto-fix
  Plug 'rstacruz/vim-closer'                  " Auto-close
  Plug 'easymotion/vim-easymotion'            " Improved motion
  " Intellisense engine
  " Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
  Plug 'reasonml-editor/vim-reason-plus'
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  let g:deoplete#enable_at_startup = 1
  " Plug 'christoomey/vim-tmux-navigator'       " Tmux/Neovim integration
  Plug 'Shougo/denite.nvim'                   " Fuzzy finding, buffer mgmt
  Plug 'Shougo/neosnippet'
  Plug 'Shougo/neosnippet-snippets'
  Plug 'Shougo/echodoc.vim'                   " Print func sig in echo area
  Plug 'heavenshell/vim-jsdoc'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-commentary'
  " Plug 'vim-syntastic/commentary'
  Plug 'whatyouhide/vim-gotham'
  Plug 'itchyny/vim-cursorword'
  Plug 'vimwiki/vimwiki'
  let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
  Plug 'junegunn/gv.vim'                     " GV a git commit browser
  Plug 'junegunn/goyo.vim'                   " Distraction free writing
  Plug 'junegunn/limelight.vim'                  " Lighting the way
  Plug 'sjl/gundo.vim'
  Plug 'reedes/vim-wordy'
  Plug 'tomlion/vim-solidity'
" }}}

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release --locked
    else
      !cargo build --release --locked --no-default-features --features json-rpc
    endif
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

" Git {{{
  " Enable git changes to be shown in sign column
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
" }}}

" Web {{{
   Plug 'HerringtonDarkholme/yats.vim'          " Typescript syntax highlighting
   Plug 'mxw/vim-jsx'                           " ReactJS JSX syntax highlighting
   Plug 'heavenshell/vim-jsdoc'                  " Generate JSDoc commands based on function signature
   Plug 'elzr/vim-json'
   Plug 'vim-syntastic/syntastic'
   Plug 'othree/html5.vim'
   Plug 'cakebaker/scss-syntax.vim'
   Plug 'hail2u/vim-css3-syntax'
   Plug 'ap/vim-css-color'
   Plug 'moll/vim-node'                           " Async linting engine
" }}}

" Syntax Highlighting {{{
  Plug 'chr4/nginx.vim'                               " Syntax highlighting for nginx
  Plug 'othree/javascript-libraries-syntax.vim'       " Syntax highlighting for javascript libraries
  Plug 'othree/yajs.vim'                              " Improved syntax highlighting and indentation
" " }}}

" UI {{{
  " File explorer
  Plug 'scrooloose/nerdtree'

  " Colorscheme
  Plug 'mhartington/oceanic-next'

  " Customized vim status line
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Icons
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" }}}

" Initialize plugin system
call plug#end()
