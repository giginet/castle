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
NeoBundle 'https://github.com/ujihisa/quickrun'
NeoBundle 'https://github.com/Shougo/unite.vim'
NeoBundle 'https://github.com/scrooloose/nerdtree'
NeoBundle 'https://github.com/mattn/gist-vim'
NeoBundle 'https://github.com/thinca/vim-ref'
NeoBundle 'https://github.com/vim-scripts/tComment'
NeoBundle 'https://github.com/Shougo/neocomplcache'
NeoBundle 'https://github.com/Shougo/neobundle.vim'
NeoBundle 'https://github.com/vim-scripts/errormarker.vim'
NeoBundle 'https://github.com/reinh/vim-makegreen.git'
NeoBundle 'https://github.com/sjl/gundo.vim'
NeoBundle 'https://github.com/mrtazz/simplenote.vim'
NeoBundle 'https://github.com/vim-scripts/surround.vim'
NeoBundle 'maksimr/vim-translator'
NeoBundle 'trotter/autojump.vim.git'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'vim-pandoc/vim-pandoc'
NeoBundle 'lambdalisue/shareboard.vim'

"fot Python
"NeoBundle 'https://github.com/peplin/ropevim'
NeoBundle 'https://github.com/mjbrownie/pythoncomplete.vim'
NeoBundle 'https://github.com/vim-scripts/pep8'
NeoBundle 'lambdalisue/vim-django-support'
NeoBundle 'mitechie/pyflakes-pathogen'

"for JavaScript
NeoBundle 'https://github.com/basyura/jslint.vim'
NeoBundle 'https://github.com/pangloss/vim-javascript'
NeoBundle 'https://github.com/lambdalisue/nodeunit.vim'

"for CofeeScript
NeoBundle 'https://github.com/kchmck/vim-coffee-script'

"for TeX
"NeoBundle 'https://github.com/jcf/vim-latex'

"for HTML
NeoBundle 'https://github.com/mattn/zencoding-vim'
NeoBundle 'https://github.com/othree/html5.vim'
NeoBundle 'https://github.com/cakebaker/scss-syntax.vim.git'
NeoBundle 'https://github.com/hail2u/vim-css3-syntax.git'

"for Scala
NeoBundle 'https://github.com/derekwyatt/vim-scala.git'

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
