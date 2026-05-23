" setting
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd

" 見た目系
set termguicolors
set number
set cursorline
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest
set signcolumn=yes
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

" マウス・クリップボード
set mouse=a
set clipboard=unnamed

" VSCode風キーバインド
" Cmd系は端末側 (iTerm2/Ghostty) で Cmd+X → \e:w\r 等のテキスト送信に設定する
" Ctrl+S フォールバック (.zshrc に 'stty -ixon' が必要)
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>

" === Color Scheme: Cursor/VSCode-like Dark Orange ===
set background=dark
syntax enable

hi clear
if exists('syntax_on')
  syntax reset
endif

" UI
hi Normal           guifg=#dcdcdc guibg=#2a2a2a
hi NormalNC         guifg=#9c9c9c guibg=#2a2a2a
hi CursorLine       guibg=#2f2f2f
hi CursorLineNr     guifg=#e67e22 guibg=#2f2f2f gui=bold
hi LineNr           guifg=#9c9c9c guibg=#2a2a2a
hi SignColumn       guibg=#2a2a2a
hi VertSplit        guifg=#4a4a4a guibg=#2a2a2a
hi StatusLine       guifg=#dcdcdc guibg=#2a2a2a gui=bold
hi StatusLineNC     guifg=#9c9c9c guibg=#101010
hi TabLine          guifg=#9c9c9c guibg=#101010
hi TabLineSel       guifg=#dcdcdc guibg=#2a2a2a gui=bold
hi TabLineFill      guifg=NONE    guibg=#101010
hi Pmenu            guifg=#dcdcdc guibg=#383838
hi PmenuSel         guifg=#dcdcdc guibg=#d35400 gui=bold
hi PmenuSbar        guibg=#101010
hi PmenuThumb       guibg=#9c9c9c
hi WildMenu         guifg=#2a2a2a guibg=#e67e22 gui=bold
hi Visual           guibg=#914410
hi Search           guifg=#2a2a2a guibg=#e67e22 gui=bold
hi IncSearch        guifg=#2a2a2a guibg=#d35400 gui=bold
hi MatchParen       guifg=#1abc9c guibg=NONE    gui=bold,underline
hi Folded           guifg=#9c9c9c guibg=#101010
hi FoldColumn       guifg=#9c9c9c guibg=#2a2a2a
hi NonText          guifg=#4a4a4a
hi SpecialKey       guifg=#4a4a4a
hi Directory        guifg=#1abc9c gui=bold
hi Title            guifg=#e67e22 gui=bold
hi ErrorMsg         guifg=#dcdcdc guibg=#c0392b
hi WarningMsg       guifg=#e67e22
hi ModeMsg          guifg=#e67e22 gui=bold
hi Question         guifg=#1abc9c gui=bold
hi DiffAdd          guifg=#1abc9c guibg=#2a2a2a
hi DiffChange       guifg=#e67e22 guibg=#2a2a2a
hi DiffDelete       guifg=#c0392b guibg=#2a2a2a
hi DiffText         guifg=#e67e22 guibg=#2f2f2f gui=bold

" Syntax
hi Comment          guifg=#6a6a6a gui=italic
hi Constant         guifg=#3498db
hi String           guifg=#e67e22
hi Character        guifg=#e67e22
hi Number           guifg=#9b59b6
hi Boolean          guifg=#9b59b6
hi Float            guifg=#9b59b6
hi Identifier       guifg=#dcdcdc
hi Function         guifg=#f1c40f
hi Statement        guifg=#d35400 gui=bold
hi Conditional      guifg=#d35400 gui=bold
hi Repeat           guifg=#d35400 gui=bold
hi Label            guifg=#d35400
hi Operator         guifg=#dcdcdc
hi Keyword          guifg=#d35400 gui=bold
hi Exception        guifg=#c0392b gui=bold
hi PreProc          guifg=#1abc9c
hi Include          guifg=#1abc9c
hi Define           guifg=#1abc9c
hi Macro            guifg=#1abc9c
hi PreCondit        guifg=#1abc9c
hi Type             guifg=#1abc9c gui=bold
hi StorageClass     guifg=#1abc9c
hi Structure        guifg=#1abc9c
hi Typedef          guifg=#1abc9c
hi Special          guifg=#e67e22
hi SpecialChar      guifg=#e67e22
hi Tag              guifg=#1abc9c
hi Delimiter        guifg=#9c9c9c
hi SpecialComment   guifg=#6a6a6a gui=bold
hi Debug            guifg=#c0392b
hi Underlined       guifg=#3498db gui=underline
hi Error            guifg=#dcdcdc guibg=#c0392b
hi Todo             guifg=#2a2a2a guibg=#f1c40f gui=bold
