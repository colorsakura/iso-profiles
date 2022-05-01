" vim: foldmethod=marker foldenable

" Disclaim ------------ {{{
"Chao Wang's personal vim configurations.
"Repo: https://github.com/hit9/dotfiles
"Feel free to use for any purpose, but try it on your own risk.
"-----------  Vim Makes World Better -------------
"---------}}}

"Plugins ------------------------------ {{{
set nocompatible               " be iMproved
filetype on                   " required!

call plug#begin('~/.vim/plugged')

"Colorschemes.
Plug 'NLKNguyen/papercolor-theme'

"StatusBar.
Plug 'itchyny/lightline.vim' "A light and configurable statusline/tabline plugin for Vim
"File Explorer.
"Best file explore window plugin..
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"A plugin of NERDTree showing git status flags.
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
"Range, pattern and substitute preview. :substite :smagic :snomagic
Plug 'markonm/traces.vim'
"Completeion
"Plug 'neoclide/coc.nvim', { 'branch': 'release' }
"Visualization Enchance.
Plug 'Yggdroot/indentLine' "Visualize us indent levels.
"Fast Movement, Motions.
Plug 'jayflo/vim-skip' "Fast move in current line via binary-search way. Type s or S to try.
" Plug 'unblevable/quick-scope' "Realtime highlight on `f` motions and f<char> to move on.
"Fast Editing.
Plug 'jiangmiao/auto-pairs' "Auto close pairs ((),{},[]).
Plug 'tpope/vim-commentary' "Type '\\' aka <Leader><Leader> to quick (un)comment line(s).
Plug 'mg979/vim-visual-multi' "Multiple cursors plugin for vim/neovim
"Marks
" Plug 'kshenoy/vim-signature' "Plugin to toggle, display and navigate marks
"Linting/Fixing.
Plug 'dense-analysis/ale' "Asynchronous linting/fixing for Vim
"Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
"git - Show diff signs for file changes under git/hg/svn control.
Plug 'mhinz/vim-signify'
"Tags
Plug 'liuchengxu/vista.vim'
"Window
Plug 'simeji/winresizer' "Window resizer
Plug 'troydm/zoomwintab.vim'

"Language: Javascript
Plug 'pangloss/vim-javascript' "Js syntax plugin.
"Language: Python
Plug 'vim-python/python-syntax' "Python syntax.
"Language: C/C++
Plug 'octol/vim-cpp-enhanced-highlight'
"Language: Go
"A golang syntax highlighting plugin
Plug 'hit9/vim-go-syntax'
"Language: Rust
Plug 'rust-lang/rust.vim' "Rust syntax.
"Language: Markdown
Plug 'gabrielelana/vim-markdown'
"Language: Misc
Plug 'elzr/vim-json'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'Glench/Vim-Jinja2-Syntax'
"Language: ruby
Plug 'hit9/bitproto', {'rtp': 'editors/vim', 'as': 'bitproto'}

if has('nvim')
    " NVIM Only
    Plug 'nvim-lua/plenary.nvim'
    Plug 'sindrets/diffview.nvim' "Wonderful diff plugin!
endif

"Plug 'vim-ruby/vim-ruby'
call plug#end()

"Plugin  -------------------------------- }}}

"Basic ------------------------------------------------ {{{

filetype plugin indent on "This should be after bundles.

"Normal settings.
set shell=/bin/zsh  "Make vim to use `/bin/sh` instead of `$SHELL`.
set noeb "Disable bells.
set re=1 "Force vim to use a older version of regex engine and it is actually FASTER.
set ttyfast "Indicates a fast terminal connection. (see :help ttyfast).
set lazyredraw "Same, faster vim.

"Normal :: Mouse.
set mouse=a "Enable mouse.
set selection=exclusive "Mouse can only selects the block where ths cursor is on.
set selectmode=mouse,key

set mousehide "Hide mouse cursor on keyboard typing.
set mousemodel=popup "Right mouse button pops up a menu.

"Syntax
syntax enable "Enable syntax.
set synmaxcol=300 "Don't perform highlight on lines that are longer than 300 chars.
syntax sync minlines=1000

"Display :: Window
set number  "Show line numbers.
"set relativenumber "Show relative line numbers.
set go= "Disable gvim's gui menu. (But I never use gui version).
if !has('nvim')
   "Use screen-256color for Vim8.
    set term=screen-256color
endif
set shortmess=atI "Disable the short message on vim start.
set noshowcmd "Don't show command in the last line of screeen.
set showmode "If in Insert, Replace or Visual mode put a message on the last line.
set nowrap "Lines longer than the width of window will wrap and displaying continues on the next line.

"Display :: Statusbar
set laststatus=2 "Always show status line on the last window.
set ruler "Show line and column number of where cursor is.

"Display :: Terminal title
set title "Makes terminal title is set by vim.
set titleold= "Restore old title after leaving vim.

"Display :: Scroll/Cursor
"https://stackoverflow.com/posts/1276428/revisions
"Cursor which always stays in the middle of screen is cool.
set scrolloff=9999

"Search/Replace
set gdefault "The :s/<search-target>/<to-replace-with>/ is s///g by default
set hlsearch "Highlight search results.
set incsearch "Realtime search results showing.

"Editing.
set autoread "Auto updates current file if this file is updated by outer.
set hidden "Opening a new file when the current buffer has unsaved changes causes files to be hidden instead of closed.
set autochdir "Auto switch current working directory to current editing file's directory.

"Editing :: Encodings --- We all use utf8 please.
set encoding=utf-8
set fencs=utf-8 "Encoding that creating new files.
set termencoding=utf-8 "Encoding that output to terminal.
set fileencoding=utf-8 "Encoding that saving files.
set backspace=indent,eol,start "Backspace key, I just don't rely on it.

" Editing :: fold, by indent
set nofoldenable
set foldmethod=manual
set foldcolumn=2
set foldlevel=0
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo  " Which commands trigger auto-unfold
set foldclose=all  "Close all folds (which level>foldlevel) automatically when cursor leaves.
"Enable fold for programming languages.
autocmd FileType c,go,python,javascript,bitproto,protobuf setlocal foldenable

"Editing :: Copy/Paste
set clipboard=unnamed "Tmux copy issue: https://github.com/tmux/tmux/issues/543#issuecomment-248980734

"Editing :: Match
set showmatch "When a bracket is inserted, briefly jump to the matching one.
set matchtime=1 "Tenths of a second to show the matching paren.

"Editing :: Completion.
set completeopt=longest,menu
set cpt=.,w,b

"Editing :: Indent And Tabs.
set autoindent "Autoindent  makes Cmd+V works wired, so when pasting something from clipboard into vim:
               ":set paste and then Cmd+V, and rollback paste settings via :set paste.
set cindent "C style indent.
set smartindent "http://vim.wikia.com/wiki/Indenting_source_code
set expandtab "Expand tabs into spaces, by default (Python user's must-have).
set tabstop=4 "Setting 1tab = 4 spaces.
set softtabstop=4 "Number of spaces that a <Tab> counts for while editing. :set paste makes softtabstop to 0 temply.
set shiftwidth=4 "Number of spaces to use for each step of (auto)indent.

set list "Show tabs via listchars below, and display end sign after endo fline.
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮ "Chars that to display list.

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" Better display for messages
set cmdheight=2
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

"Tab settings for diferent language filetypes. (forked from humiaozuzu's dotfile.)
autocmd FileType text setlocal textwidth=79
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=90
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=79
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79
autocmd FileType coffee,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=79
autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=79

"NVim: Auto enter insert on :terminal mode.  :help :terminal
if has('nvim')
    autocmd TermOpen * startinsert
endif

"Color/Highlighting. ------------          {{{

"Enable true color support:
"https://lotabout.me/2018/true-color-for-tmux-and-vim/
"https://github.com/tmux/tmux/issues/1246
if exists('+termguicolors')
  if !has('nvim') " ------- Vim8
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  else " --------- NVIM
    set termguicolors
  endif
endif
set t_Co=256 "Enable 256 color
set background=dark "Using dark. Hmm dark is sexy.

"Set cursorline and cursorcolumn
set cursorline
set cursorcolumn

"Colorscheme Configuration :: PaperColor ----------- {{{

"Color :: CursorLine/CursorColumn (Apply after colorscheme loaded)
highlight CursorLine term=underline cterm=underline ctermbg=246 ctermfg=none guibg=#383a42
highlight CursorColumn term=none cterm=none ctermbg=244 ctermfg=none guibg=#383a42

" Color :: Normal and Visual mode.
highlight Normal term=none ctermbg=none " Make vim be transparent in terminal.
highlight Visual term=none cterm=bold ctermbg=238 ctermfg=none

let g:PaperColor_Theme_Options = {
    \   'theme': {
    \     'default.dark': {
    \        'transparent_background': 1,
    \        'override': {
    \           'visual_bg': ['#005f87', '31'],
    \           'visual_fg': ['#ffffff', '255']
    \        }
    \      }
    \   },
    \   'language': {
    \     'python': {
    \       'highlight_builtins' : 1
    \     },
    \     'cpp': {
    \       'highlight_standard_library': 1
    \     },
    \     'c': {
    \       'highlight_builtins' : 1
    \     }
    \   }
    \ }

colorscheme PaperColor

" ------------- End of PaperColorTheme ------------ }}}

""Transparent background ------- {{{
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
"----- }}}

"Plugin Configuration :: lightline.vim ----------- {{{

"https://github.com/itchyny/lightline.vim/blob/master/colorscheme.md
let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ }
"Plugin Configuration :: lightline.vim ----------- }}}

"----------- }}}

"Basic ------------------------------------------------ }}}

"Plugin Configuration :: tpope/vim-commentary ----------------- {{{

"Type `\\` to toggle comments for current line or selected blocks.
xmap <Leader><Leader>  <Plug>Commentary
nmap <Leader><Leader>  <Plug>Commentary
omap <Leader><Leader>  <Plug>Commentary
nmap <Leader><Leader>  <Plug>CommentaryLine

"Plugin Configuration :: tpope/vim-commentary ----------------- }}}

" Plugin Configuration :: neoclide/coc.nvim ---------- {{{
au FileType go,python,c,cpp,javascript,rust nmap <silent> gd <Plug>(coc-definition)
au FileType go,python,c,cpp,javascript,rust nmap <silent> gD <Plug>(coc-implementation)
au FileType go,python,c,cpp,javascript,rust nmap <silent> gv :call CocAction('jumpDefinition', 'vsplit')<CR>
"Plugin Configuration :: neoclide/coc.nvim ---------- }}}

" Configuration :: scrooloose/nerdtree --------- {{{
"Open nerdtree on buffer entered. And close it if it's the last window.
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"nerdtree window's width.
let NERDTreeWinSize=35
"Show line number for nerdtree.
let NERDTreeShowLineNumbers=1
"Don't display these files:
let NERDTreeIgnore=['\.pyc$', '\.o$', '\~$', '__pycache__', '\.mypy_cache', '\.DS_Store',
    \ '^\.git$', '\.o$', '\.so$', '\.egg$', "\.pytest_cache", "\.swp$", "\.swo$", "\.swn$"]
" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1
" Show hidden files, too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

"User-defined custom command `:NT` to toggle nerdtree window
:command NT :NERDTreeToggle

"Plugin Configuration :: scrooloose/nerdtree --------- }}}

"Plugin Configuration :: Yggdroot/indentLine ------------------------- {{{
let g:indentLine_char = '|'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '-'
"https://github.com/Yggdroot/indentLine/issues/47
" autocmd FileType help,nerdtree IndentLinesToggle
autocmd FileType help IndentLinesToggle
"Plugin Configuration :: Yggdroot/indentLine ------------------------- }}}

"Plugin Configuration :: pangloss/vim-javascript -------------- {{{
let javascript_enable_domhtmlcss = 1
let g:javascript_plugin_jsdoc = 1
"Plugin Configuration :: pangloss/vim-javascript -------------- }}}

"Plugin Configuration :: vim-python/python-syntax ---------------- {{{
let python_highlight_all = 1
let python_slow_sync = 0
"Plugin Configuration :: vim-python/python-syntax ----------------- }}}

"Plugin Configuration :: rust-lang/rust.vim && racer -------------------- {{{
let g:rustfmt_autosave = 0  " Use ale for rust formatting.
"Plugin Configuration :: rust-lang/rust.vim && racer -------------------- }}}

"Plugin Configuration :: vim-json --------------------- {{{
let g:vim_json_syntax_conceal = 0
"Plugin Configuration :: vim-json ----------------------------- }}}

"Plugin Configuration :: w0rp/ale -------------------------------- {{{
" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:ale_linters = {
    \   'javascript': ['standard'],
    \   'python': ['black', 'mypy'],
    \   'c': ['clang-format'],
    \   'cpp': ['clang-format'],
    \   'rust': ['cargo', 'rls'],
\}
let g:ale_fixers_explicit = 1
let g:ale_fixers = {
    \   'javascript': ['standard'],
    \   'python': ['black'],
    \   'c': ['clang-format'],
    \   'cpp': ['clang-format'],
    \   'go': ['gofmt'],
    \   'rust': ['rustfmt'],
\}
let g:ale_fix_on_save = 1
let g:python_mypy_show_notes = 1
let g:ale_python_vulture_options = '--min-confidence 80 --exclude "*pb2.py,*pb2_grpc.py,*.egg-info,dist/*,"'
let g:ale_rust_rls_toolchain = 'nightly'
"Plugin Configuration :: w0rp/ale -------------------------------- }}}

"Plugin Configuration :: mg979/vim-visual-multi ------- {{{
let g:VM_theme = 'iceblue' "https://github.com/mg979/vim-visual-multi/wiki/Highlight-colors
" Won't use default leader key \\, using Ctrl-N instead.
" Select words: Ctrl-N and press N for next word.
" Multiple lines: visual mode selection section, and Ctrl-N
" Select all occurences of current word: Ctrl-N and press A quickly
let g:VM_leader = '<C-n>'
let g:VM_maps = {}
let g:VM_maps["Visual Add"] = '<C-n>'


"}}}

"Plugin Configuration :: mhinz/vim-signify ----------------- {{{
highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
highlight SignifySignAdd ctermfg=yellow ctermbg=green guifg=#F7DC6F guibg=#1E8449
highlight SignifySignChange ctermfg=yellow ctermbg=blue guifg=#F7DC6F guibg=#2874A6
highlight SignifySignDelete ctermfg=yellow ctermbg=red guifg=#F7DC6F guibg=#EC7063
"Plugin Configuration :: mhinz/vim-signify }}}

"Plugin Configuration :: gabrielelana/vim-markdown ---------- {{{
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_conceal = 0
"Plugin Configuration :: gabrielelana/vim-markdown ---------- }}}
"
"Custom :: WhiteSpaces Cleaning ----------------------------  {{{

"Highlight trailing whitespaces as red.
"http://vim.wikia.com/wiki/Highlight_unwanted_spaces.
highlight ExtraWhitespace ctermbg=red guibg=#EC7063
match ExtraWhitespace /\s\+$/

"Clean trailing whitespaces on buffer's save.
"Command :WS is to clean trailing whitespaces.
:command WS :%s/\s\+$//e

"Auto clean whitespaces on buffer save for this files.
autocmd BufWrite *.c,*.h,*.go,*.py,*.js,*.html,*.md,.vimrc,*.ini,*.toml,*.markdown,*.yaml,*.proto,*.bitproto,*.rst :WS
"------- }}}

"Plugin Configuration :: junegunn/fzf.vim ----------------- {{{
" ProjectFiles tries to locate files relative to the git root contained in
" NerdTree, falling back to the current NerdTree dir if not available
" see https://github.com/junegunn/fzf.vim/issues/47#issuecomment-160237795
function! s:find_git_root()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()
nmap <c-p> :ProjectFiles<CR>
nmap <c-b> :Buffers<CR>

" let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'horizontal'  }  }
" Customize fzf colors to match your color scheme
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.5 } }
"Plugin Configuration :: junegunn/fzf.vim ----------------- }}}

"Plugin Configuration :: unblevable/quick-scope ------------- {{{
highlight QuickScopePrimary ctermfg=119 cterm=underline guifg='#afff5f' gui=underline
highlight QuickScopeSecondary ctermfg=81 cterm=none guifg='#5fffff' gui=underline

let g:qs_max_chars=180 "Max number of chars to highlight in one line.
" let g:qs_lazy_highlight = 1 " https://github.com/unblevable/quick-scope#lazy-highlight
" let g:qs_highlight_on_keys = ['f', 'F']
let g:qs_second_highlight = 0
let g:qs_ignorecase = 1
"Plugin Configuration :: unblevable/quick-scope ------------- }}}

"Plugin Yggdroot/hiPairs -------------------------------- {{{
let g:hiPairs_hl_matchPair = { 'term'    : 'underline,bold',
    \                  'cterm'   : 'bold',
    \                  'ctermfg' : '15',
    \                  'ctermbg' : '24',
    \                  'gui'     : 'bold',
    \                  'guifg'   : '#ffffff',
    \                  'guibg'   : '#005f87' }
" -------------------------------------------------------- }}}

"Custom :: Window Switches ----------------------------  {{{

"Plugin simeji/winresizer ---------------- {{{
let g:winresizer_start_key = '<C-E>'
"Plugin simeji/winresizer ---------------- }}}

"Shortcut window switches, w+h/j/k/l
nmap wk <c-w><up>
nmap wh <c-w><left>
nmap wl <c-w><right>
nmap wj <c-w><down>
nmap wz <c-w>o  " Zoom
"Custom :: Window Switches ----------------------------  }}}

" Folding -------------- {{{
" Mappings to easily toggle fold levels
nmap z0 :set foldlevel=0<CR>
nmap z1 :set foldlevel=1<CR>
nmap z2 :set foldlevel=2<CR>
nmap z3 :set foldlevel=3<CR>
"-----------}}}

"Custom :: git / tig ----------------------------  {{{
if has('nvim')
    command! Blame  :terminal tig blame %
else
    command! Blame  :!tig blame %
endif
"Custom :: git / tig ----------------------------  }}}
