"Initialize NeoBundle
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim
  call neobundle#rc(expand('~/.bundle'))
endif


" 北大のクソネットワークではgitプロトコルによるcloneができないので
" あえてusername/repositoryという書き方をしていない

"Universal Plugins
NeoBundle 'gujihisa/quickrun'
NeoBundle 'gShougo/unite.vim'
NeoBundle 'gscrooloose/nerdtree'
NeoBundle 'gmattn/gist-vim'
NeoBundle 'gthinca/vim-ref'
NeoBundle 'gvim-scripts/tComment'
NeoBundle 'gShougo/neocomplcache'
NeoBundle 'gShougo/neobundle.vim'
NeoBundle 'gvim-scripts/errormarker.vim'
NeoBundle 'greinh/vim-makegreen.git'
NeoBundle 'gsjl/gundo.vim'
NeoBundle 'gmrtazz/simplenote.vim'
NeoBundle 'gvim-scripts/surround.vim'

"fot Python
"NeoBundle 'gpeplin/ropevim'
NeoBundle 'gmjbrownie/pythoncomplete.vim'
NeoBundle 'gvim-scripts/pep8'
NeoBundle 'lambdalisue/vim-django-support'
NeoBundle 'mitechie/pyflakes-pathogen'

"for JavaScript
NeoBundle 'gbasyura/jslint.vim'
NeoBundle 'gpangloss/vim-javascript'
NeoBundle 'glambdalisue/nodeunit.vim'

"for CofeeScript
NeoBundle 'gkchmck/vim-coffee-script'

"for TypeScript
NeoBundle 'leafgarland/typescript-vim'

"for TeX
"NeoBundle 'gjcf/vim-latex'

"for HTML
NeoBundle 'gmattn/zencoding-vim'
NeoBundle 'gothree/html5.vim'
NeoBundle 'gcakebaker/scss-syntax.vim.git'
NeoBundle 'ghail2u/vim-css3-syntax.git'

"for Scala
NeoBundle 'gderekwyatt/vim-scala.git'

"for restructuredText
NeoBundle 'mattn/mkdpreview-vim'
NeoBundle 'mattn/webapi-vim'

filetype plugin indent on
