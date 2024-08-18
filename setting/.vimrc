"################################################
"# 文字
"################################################

set fenc=utf-8
set autoindent
set smartindent

"################################################
"# 表示
"################################################
set laststatus=2
set number
set showmatch
set showcmd
set visualbell
set cursorline
set virtualedit=onemore
syntax enable
set list listchars=tab:\▸\-
set background=dark
set statusline=%F%r%=%l,%c
set hlsearch

"################################################
"# インデント
"################################################

set expandtab
set shiftwidth=2
set tabstop=2

"################################################
"# 検索
"################################################

" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
set ambiwidth=double

"################################################
"# キーマップ
"################################################

inoremap <silent> jk <ESC>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <C-j> <C-f>
nnoremap <C-k> <C-b>
vnoremap <C-j> <C-f>
vnoremap <C-k> <C-b>

nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k
vnoremap j gj
vnoremap gj j
vnoremap k gk
vnoremap gk k

let mapleader = "\<space>"

" ウィンドウ関係
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>s :split<CR>
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>h <C-w>h
nnoremap <Leader>l <C-w>l
nnoremap <Leader>0 <C-w>q
nnoremap <Leader>1 <C-w>o

" バッファ関係
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bls :ls<CR>
nnoremap <Leader>bf :b

" 検索
nnoremap <slient> <Esc><Esc> :nohlsearch<CR>
nnoremap n nzz
nnoremap N Nzz

" ターミナル設定
:set termwinkey=<space> 

" そのほか
nnoremap Y y$
nnoremap Q <Nop>

call plug#begin()
  Plug 'preservim/nerdtree'
call plug#end()

