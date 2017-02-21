"General Settings
set cindent
set cinoptions=g0
set directory=$HOME/.vimbackup
set smartindent
set title
set mouse=a
set shortmess=a

"Language Settings
set encoding=utf8
set fileencoding=utf8
set hlg=en
language C

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

" Bootstrap dein.vim
if &compatible
  set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

call dein#begin('~/.cache/dein')

call dein#add('Shougo/dein.vim')

call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 1})

call dein#end()

filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

"Python support
let g:python2_host_prog = expand('$HOME') . '/.pyenv/versions/2.7.10/bin/python'
let g:python3_host_prog = expand('$HOME') . '/.pyenv/shims/python'

"vimfiler Settings
nnoremap <C-n>t :VimFilerExplorer<CR>
" close vimfiler automatically when there are only vimfiler open
autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
if dein#tap("vimfiler")
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
endif

"Quickrun Settings
silent! nmap <unique> <C-x><C-x> <Plug>(quickrun)
if dein#tap("vim-quickrun")
  let g:loaded_quicklaunch = 1
  let g:quickrun_config = {
      \ "*": {"runner": "remote/vimproc"},
      \ 'split': '{"rightbelow 10sp"}'
      \ }
endif

"Investigate.vim Settings
if dein#tap("investigate.vim")
  let g:investigate_use_dash = 1
endif

"vim-gista Settings
if dein#tap("vim-gista")
  let g:gista#client#use_git_config_github_username = 1
endif

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
  if dein#tap("deoplete.nvim")
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_smart_case = 1
    set completeopt+=noinsert
  endif
else
  if dein#tap("neocomplete.vim")
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_at_startup = 1
  endif
endif

if dein#tap('deoplete-jedi')
  let g:jedi#completions_enabled = 1
endif

augroup MyAutoCmd
  autocmd!
augroup END

if dein#tap('vim-emoji')
  function! s:enable_emoji_complete() abort
    setlocal completefunc=emoji#complete
    setlocal omnifunc=emoji#complete
  endfunction

  execute 'autocmd MyAutoCmd User' 'dein#source#' . g:dein#name
        \ 'call s:enable_emoji_complete()'
end

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
