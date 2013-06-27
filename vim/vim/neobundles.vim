"Initialize NeoBundle
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim
  call neobundle#rc(expand('~/.bundle'))
  NeoBundleFetch 'Shougo/neobundle.vim'
  NeoBundleCheck
endif


"Universal Plugins
NeoBundle 'ujihisa/quickrun'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'mattn/gist-vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'vim-scripts/tComment'
NeoBundle 'vim-scripts/errormarker.vim'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'mrtazz/simplenote.vim'
NeoBundle 'vim-scripts/surround.vim'
NeoBundle 'maksimr/vim-translator'
NeoBundle 'trotter/autojump.vim.git'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'vim-pandoc/vim-pandoc'
NeoBundle 'lambdalisue/shareboard.vim'
NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ "autoload": {"insert": 1}}
let s:hooks = neobundle#get_hooks("neocomplete.vim")
function! s:hooks.on_source(bundle)
    let g:acp_enableAtStartup = 0
    let g:neocomplete#enable_smart_case = 1
    NeoCompleteEnable
endfunction

"fot Python
NeoBundleLazy "davidhalter/jedi-vim", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"],
      \   "build": {
      \     "mac": "pip install jedi",
      \     "unix": "pip install jedi",
      \   }
      \ }}
let s:hooks = neobundle#get_hooks("jedi-vim")
function! s:hooks.on_source(bundle)
  let g:jedi#auto_vim_configuration = 0
  let g:jedi#popup_select_first = 0
  let g:jedi#rename_command = '<Leader>R'
  let g:jedi#goto_command = '<Leader>G'
endfunction

"for JavaScript
NeoBundle 'basyura/jslint.vim'
NeoBundle 'pangloss/vim-javascript'

"for CofeeScript
NeoBundle 'kchmck/vim-coffee-script'

"for TeX
"NeoBundle 'https://github.com/jcf/vim-latex'

"for HTML
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'othree/html5.vim'
NeoBundle 'cakebaker/scss-syntax.vim.git'
NeoBundle 'hail2u/vim-css3-syntax.git'

"for Scala
NeoBundle 'derekwyatt/vim-scala.git'

"for Lua
NeoBundle 'lua-support'

"for Puppet
NeoBundle 'rodjek/vim-puppet'

"for Groovy
NeoBundle 'groovy.vim'

"for MoonScript
NeoBundle 'leafo/moonscript-vim'

"for restructuredText
NeoBundle 'mattn/mkdpreview-vim'
NeoBundle 'mattn/webapi-vim'

filetype plugin indent on
