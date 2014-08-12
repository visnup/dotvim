" This must be first, because it changes other options as a side effect.
set nocompatible

" Pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

set backspace=indent,eol,start  " allow backspacing over everything
set ruler                       " show the cursor position all the time

set nobackup        " do not keep a backup file, use versions instead
set history=50      " keep 50 lines of command line history
set undofile
set undodir=~/.vim/tmp
set dir=~/.vim/tmp

set expandtab       " expand tabs to spaces
set shiftwidth=2    " indent by 2 spaces
set tabstop=2       " tab by 2 spaces

set ignorecase      " ignore case while searching
set smartcase       " ...unless query has uppercase in it
set hlsearch        " highlight search terms

set splitright      " split things to the right
set splitbelow      " split things to the bottom
let g:netrw_altv = 2

autocmd FocusLost * silent! wa        " write files on defocus
set autoread                          " re-read files on focus

set showcmd                           " display incomplete commands
set wildmode=list:longest,list:full   " ex tab completion
set wildignore+=*.o,*.obj,*.rbc,.git  ",vendor/ruby/**,node_modules/**

let mapleader = ','

let g:ctrlp_custom_ignore = 'vendor/ruby\|node_modules|tmp'

" Don't use Ex mode, use Q for formatting
map Q gq

" My own oft used keys
nnoremap <Leader>t :CtrlP<CR>
nnoremap <Leader>g :grep 
nnoremap <Leader><space> :noh<CR>
nnoremap <Leader>n :w<CR>:cn<CR>
nnoremap <Leader>p :w<CR>:cN<CR>

" cmd-][ indents lines in visual mode
vmap <D-[> <gv
vmap <D-]> >gv

" Make ex mode more OSX/emacs-y
cnoremap <C-A> <Home>
cnoremap <C-D> <Del>
cnoremap <M-B> <S-Left>
cnoremap <M-F> <S-Right>
cnoremap <M-BS> <C-W>

" Macros:
" Ruby 1.8 -> 1.9 Hash Replacement
nnoremap <Leader>h :%s/\v:(\w+)\s?\=\>/\1:/g<CR>

if &t_Co > 16 || has("gui_running")
  colorscheme xoria256
endif

" Setup for multibyte
if has("multi_byte")
  set fileencodings=ucs-bom,utf-8
endif

" Syntax highlighting
syntax on
filetype plugin indent on

" Filetype aliases
autocmd BufNewFile,BufRead *.ejs set filetype=html
autocmd BufNewFile,BufRead *.skim set filetype=slim
autocmd BufNewFile,BufRead *.emblem set filetype=jade
autocmd BufNewFile,BufRead *.styl.* set filetype=stylus
autocmd BufNewFile,BufRead *.less set filetype=scss

" Filetype specific changes
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Create missing parent directories when saving new files
autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p %:h" | redraw! | endif

" Auto-open quickfix window after any grep
autocmd QuickFixCmdPost *grep* cwindow

if has("gui_running")
  set lines=48 columns=80
  set guifont=Inconsolata:h16.00
  set transparency=5
  set toolbar=icons,text
  set guioptions-=T
endif

" Replace searching with the silver searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>
  let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching=0
endif
