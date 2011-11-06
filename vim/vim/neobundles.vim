"Initialize NeoBundle
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim
  call neobundle#rc(expand('~/.bundle'))
endif

"Universal Plugins
NeoBundle 'ujihisa/quickrun'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'mattn/gist-vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'vim-scripts/tComment'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'vim-scripts/errormarker.vim'
NeoBundle 'https://github.com/reinh/vim-makegreen.git'

"fot Python
NeoBundle 'peplin/ropevim'
NeoBundle 'mjbrownie/pythoncomplete.vim'
NeoBundle 'vim-scripts/pep8'

"for JavaScript
NeoBundle 'basyura/jslint.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'lambdalisue/nodeunit.vim'

"for CofeeScript
NeoBundle 'kchmck/vim-coffee-script'

"for TeX
"NeoBundle 'jcf/vim-latex'

"for HTML
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'othree/html5.vim'

filetype plugin indent on
