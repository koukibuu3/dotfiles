" setting
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd

" 見た目系
hi Comment ctermfg=gray
set number
set cursorline
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest
nnoremap j gj
nnoremap k gk

" Tab系
set list listchars=tab:\▸\-
set expandtab
set tabstop=2
set shiftwidth=2

" 検索系
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>
