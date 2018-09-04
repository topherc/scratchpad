" vim: set syntax=vim

" {{{ VIM SECURITY DO NOT CHANGE
" ====== MODELINE ======
" Allow Documents to set VIM settings
" Example: vim: set syntax=vim
" DO NOT ENABLE MODELINES WIHOUT THE SECURE_MODELINE PLUGIN INSTALLED
" http://www.vim.org/scripts/script.php?script_id=1876
" SEE https://github.com/ciaranm/securemodelines
if (! exists("g:loaded_securemodelines"))
    set modeline
    "echom "SecureModeLines Plugin Loaded: modeline set"
endif 

" ====== SET SECURE =======
" Shell and write commands are not allowed in .vimrc
" See http://vimdoc.sourceforge.net/htmldoc/options.html#'secure'
set secure

" }}} VIM SECURITY DO NOTCHANGE

" ====== DISPLAY ======
" No wrap lines & toggle
set nowrap
:map <F5> :set nowrap! <CR>

set number
set ttyfast
set title
set ambiwidth=double

" Viewing Whitespace
set listchars=eol:$,tab:▸▹,nbsp:‿,trail:⁔,extends:>,precedes:<
set nolist


" ======== Tabs ========
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'

" ======== SEARCH & MOVEMENT OPTIONS =====
set smartcase
set hlsearch      " Highligh Searches
set incsearch     " Incremental search
set wrapscan      " Wrap back to top of doc search
set ignorecase    "search ignoring case

"Search centering
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap g* g*zzzv
nnoremap g# g#zzzv

"make navigating wrapped lines easier
noremap j gj
noremap k gk
noremap gj j
noremap gk k

"fold navigation
set foldmethod=marker

" ======= INDENT GUIDE PLUGIN ====
" https://github.com/nathanaelkane/vim-indent-guides
" set background=dark
" let g:indent_guides_auto_colors = 0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
" hi IndentGuidesOdd  ctermbg=black
" hi IndentGuidesEven ctermbg=darkgrey


set showmatch     " set show matching parenthesis
set nocompatible    " be iMproved
set laststatus=2    " always show status line
set ruler
set history=100
set showmode

set showcmd
set wildmenu        " enhanced command-line completion
set wildmode=list:longest,full
set completeopt=menuone
set cmdheight=1
set previewheight=40

" ======== STATUS LINE =============
let &statusline = ''
let &statusline .= 'Buf ID:%3n   '        "Buffer Number
let &statusline .= 'File:%<%f   '       "filename
let &statusline .= 'Flags:%m%r%h%w   '   "Modified Flag, Readonly Flag, Preview flag
let &statusline .= 'Pos:%l,%c%V     '     "Line, Column, Virtual Column
let &statusline .= 'File:%4P'         "Percent through file of the displayed window


" Show History in command mode 
nnoremap : q:i
" Show History in search mode 
nnoremap / q/i
" Show History in ? mode 
nnoremap ? q?i

" ======== KEY REMAPS =========
" alternate method to exit insert mode with jk
imap jk <Esc>

""" Remapped keys
" swap ; and : in normal mode
" nnoremap ; :
" nnoremap : ;
" TC 4/5/2015-Little weird for me since I'm used to :

"Quick repeat of last command on the next line
map  j.

"======== COLORS & Syntax Highlighting ========
"Link http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
filetype on
syntax enable
syntax on
filetype plugin on


if $TERM=~? '256' || has('gui_running')
  colorscheme candycode
  "colorscheme vividchalk
  "colorscheme abbott
  "colorscheme railscasts2
  "colorscheme molokai
  "colorscheme sunburst
endif

" ======== CURSOR HIGHLIGHTING OPTIONS ==========
" Line & Column Highlighting
"hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorLine   cterm=NONE ctermbg=233 guibg=#121212
"hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=233 guibg=#121212
" :nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
set cursorline
set cursorcolumn


" Remove auto indent so that you copy/paste things into the vim terminal
if !exists("*Indoff")  " Avoid auto-reload errors when saving .vimrc
function Indoff()
  set noautoindent
  set nosmartindent
endfunction
endif

if !exists("*Indon")  " Avoid auto-reload errors when saving .vimrc
function Indon()
  set autoindent
  set smartindent
endfunction
endif

"{{{ HEX MODE
" ============ HEX MODE ========== 
nnoremap <C-H> :Hexmode<CR> 
inoremap <C-H> <Esc>:Hexmode<CR> 
vnoremap <C-H> :<C-U>Hexmode<CR> " ex command for toggling hex mode - define mapping if desired command -bar Hexmode call ToggleHex()
"
" helper function to toggle hex mode
if !exists("*ToggleHex")  " Avoid auto-reload errors when saving .vimrc
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries 
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction
endif
"}}}  HEXMOD

" ==== AUTO RELOAD .VIMRC ON MODIFY - APPLIES TO ALL OPEN VIM SESSIONS =======
augroup myvimrc
    au!
    au BufWritePost vimrc.vim,.vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" Links
" Tips http://vim.wikia.com/wiki/Category:VimTip
" https://bitbucket.org/sjl/dotfiles/src/603bb1ae9da27c6e08ab115df1cb5d8f6a1442c3/vim/vimrc?at=default

autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp
