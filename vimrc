" This must be first, because it changes other options as a side effect.
set nocompatible

" Pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup        " do not keep a backup file, use versions instead
set history=50      " keep 50 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set expandtab       " expand tabs to spaces
set shiftwidth=2    " indent by 2 spaces
set tabstop=2       " tab by 2 spaces
set ignorecase      " ignore case while searching
set smartcase       " ...unless query has uppercase in it
set hlsearch        " highlight search terms
set autoread        " re-read files on focus
set undofile
set undodir=~/.vim/tmp
set dir=~/.vim/tmp
set wildmode=list:longest,list:full   " ex tab completion
set wildignore+=*.o,*.obj,*.rbc,.git  ",vendor/ruby/**,node_modules/**

let mapleader=","

let g:ctrlp_custom_ignore='vendor/ruby\|node_modules|tmp'
let g:yankring_history_dir = '$HOME/.vim/tmp'

" Don't use Ex mode, use Q for formatting
map Q gq

" My own oft used keys
nnoremap <Leader>a :Ack<space>
nnoremap <Leader>t :CtrlP<CR>
nnoremap <Leader><space> :noh<CR>
nnoremap <Leader>n :w<CR>:cn<CR>

vmap <D-[> <gv
vmap <D-]> >gv

" Remap some keys for ex mode
cnoremap <C-A> <Home>
cnoremap <C-D> <Del>
cnoremap <M-B> <S-Left>
cnoremap <M-F> <S-Right>
cnoremap <M-BS> <C-W>

" Repetitive changes
"   Ruby 1.8 -> 1.9 Hash Replacement
nnoremap <Leader>h :%s/\v:(\w+)\s?\=\>/\1:/g<CR>

if &t_Co > 16 || has("gui_running")
  colorscheme xoria256
endif

if has("gui_running")
  set lines=48 columns=80
  set guifont=Inconsolata:h16.00
  set transparency=5
  set toolbar=icons,text
  set guioptions-=T
endif

" Setup for multibyte
if has("multi_byte")
  set fileencodings=ucs-bom,utf-8
endif

" Syntax highlighting
syntax on
filetype plugin indent on

" filetype aliases
autocmd BufNewFile,BufRead *.ejs set filetype=html
autocmd BufNewFile,BufRead *.skim set filetype=slim

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" http://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save
autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p %:h" | redraw! | endif
