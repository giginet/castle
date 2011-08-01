set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
"General Settings
set cindent
set cinoptions=g0

set directory=$HOME/.vimbackup
set smartindent
set title
"Encoding Settings
set encoding=utf8
set hlg=ja
"Edit Settings
set tabstop=2
set shiftwidth=2
set expandtab     "replace tab to spaces
set showmatch     "auto complete )
set matchtime=1   "wait time for showmatch
"Display Settings
set number
set list
set ruler
set nowrap
set shellslash
"Search Settings
set hlsearch       "enable highligt
set incsearch      "enable incremental search
set smartcase      "enable smart case
set grepprg=grep\ -nH\ $*
"
filetype plugin on
filetype plugin indent on
filetype indent on
syntax on
"Color Scheme
colorscheme summerfruit
"Key Mappings
noremap z :tabp<CR>
noremap x :tabn<CR>
noremap q :tabonly<CR>
noremap t gg=G<C-o><C-o>
noremap <C-o> :tabnew 
noremap <C-t> :new<CR>

"Plugin Settings
silent! nmap <unique> <C-r> <Plug>(quickrun)
"Bundle Plugins
Bundle 'quickrun.vim'
Bundle 'unite.vim'
Bundle 'vimlatex'
"Template設定
autocmd BufNewFile *.tex 0r $HOME/.vim/template/tex.txt
"Quickrun
"出力を下側に表示
"let g:quickrun_config = {
\ '*': {
\ 'split': '{"rightbelow 20sp"}'
\ }
\}
