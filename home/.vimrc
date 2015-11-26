"General Settings
set cindent
set cinoptions=g0
set directory=$HOME/.vimbackup
set smartindent
set title
set mouse=a

"Language Settings
set encoding=utf8
set fileencoding=utf8
set hlg=ja

"Edit Settings
set tabstop=2
set shiftwidth=2
set expandtab     "replace tab to spaces
set showmatch     "auto complete )
set matchtime=1   "wait time for showmatch
set backspace=indent,eol,start
set virtualedit=block

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

"Plugin Settings
filetype on
filetype plugin on
filetype plugin indent on
filetype indent on
syntax on

"Color Scheme
colorscheme jellybeans

"split like tmux
noremap <C-w>% :vsp<CR>
noremap <C-w>" :sp<CR>
noremap <C-w>p :tabp<CR>
noremap <C-w>n :tabn<CR>
noremap <C-w>c :tabnew<CR>

" Sync clipboard and register
set clipboard& clipboard+=unnamed

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
au BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

if has('nvim')
  source <sfile>:h/neobundles.vim
else
  source <sfile>:h/.vim/neobundles.vim
endif

"Python support
let g:python2_host_prog = expand('$HOME') . '/.pyenv/versions/2.7.10/bin/python'
let g:python3_host_prog = expand('$HOME') . '/.pyenv/shims/python'

"vimfiler Settings
nnoremap <C-n>t :VimFilerExplorer<CR>
" close vimfiler automatically when there are only vimfiler open
autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
let s:hooks = neobundle#get_hooks("vimfiler")
function! s:hooks.on_source(bundle)
  " vimfiler specific key mappings
  autocmd FileType vimfiler call s:vimfiler_settings()
  function! s:vimfiler_settings()
    "let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_enable_auto_cd = 1
    "let g:vimfiler_ignore_pattern = "^\%(.git\|.DS_Store\)$"
    " ^^ to go up
    nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
    " use R to refresh
    nmap <buffer> R <Plug>(vimfiler_redraw_screen)
    " overwrite C-l
    nmap <buffer> <C-l> <C-w>l
  endfunction
endfunction

"Quickrun Settings
silent! nmap <unique> <C-x> <Plug>(quickrun)
let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)
  let g:loaded_quicklaunch = 1
  let g:quickrun_config = {
      \ "*": {"runner": "remote/vimproc"},
      \ 'split': '{"rightbelow 10sp"}'
      \ }
endfunction

"Investigate.vim Settings
let s:hooks = neobundle#get_hooks("investigate.vim")
function! s:hooks.on_source(bundle)
  let g:investigate_use_dash = 1
endfunction

"vim-gista Settings
let s:hooks = neobundle#get_hooks("vim-gista")
function! s:hooks.on_source(bundle)
  let g:gista#github_user = 'giginet'
endfunction

"errormarker.vim Settings
let g:errormarker_errortext = '!!'
let g:errormarker_warningtext = '??'
let g:errormarker_errorgroup = 'Error'
let g:errormarker_warninggroup = 'Todo'
highlight Error ctermbg=52 guibg=#5F0000
highlight Todo ctermbg=17 guibg=#00005F

"Gundo.vim Settings
noremap U :<C-u>GundoToggle<CR>

"neocomplete Settings
if has('nvim')
  let s:hooks = neobundle#get_hooks("deoplete.nvim")
  function! s:hooks.on_source(bundle)
    let g:deoplete#enable_at_startup = 1
  endfunction
else
  let s:hooks = neobundle#get_hooks("neocomplete.vim")
  function! s:hooks.on_source(bundle)
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_at_startup = 1
  endfunction
endif

autocmd BufRead /tmp/crontab.* :set nobackup nowritebackup

"Load local Settings
if filereadable($HOME.'/.vimrc_local')
  source $HOME/.vimrc_local
endif

"Disable Arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
