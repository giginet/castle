filetype plugin off

"Initialize NeoBundle
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+='path to neobundle directory'

  call neobundle#rc(expand('~/.bundle'))
endif

"Universal Plugins
NeoBundle 'ujihisa/quickrun'
NeoBundle 'unite.vim'
NeoBundle 'The-NERD-tree'
NeoBundle 'Gist.vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'tComment'
NeoBundle 'neocomplcache'
NeoBundle 'errormarker.vim'
"fot Python
NeoBundle 'peplin/ropevim'
NeoBundle 'pythoncomplete'
NeoBundle 'vim-scripts/pep8'
"for JavaScript
NeoBundle 'basyura/jslint.vim'
NeoBundle 'pangloss/vim-javascript'
"for TeX
"NeoBundle 'jcf/vim-latex'
"for HTML
NeoBundle 'ZenCoding.vim'
NeoBundle 'othree/html5.vim'
"for CofeeScript
NeoBundle 'vim-coffee-script'

filetype plugin indent on
