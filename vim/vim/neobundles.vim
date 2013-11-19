" Initialize NeoBundle
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim
  call neobundle#rc(expand('~/.bundle'))
  NeoBundleFetch 'Shougo/neobundle.vim'
  NeoBundle "Shougo/vimproc", {
        \ "build": {
        \   "windows"   : "make -f make_mingw32.mak",
        \   "cygwin"    : "make -f make_cygwin.mak",
        \   "mac"       : "make -f make_mac.mak",
        \   "unix"      : "make -f make_unix.mak",
        \ }}

  "Universal Plugins
  NeoBundleLazy "thinca/vim-quickrun", {
        \ "autoload": {
        \   "mappings": [['nxo', '<Plug>(quickrun)']]
        \ }}
  NeoBundleLazy "Shougo/unite.vim", {
      \ "autoload": {
      \   "commands": ["Unite", "UniteWithBufferDir"]
      \ }}
  NeoBundleLazy 'mattn/gist-vim', {
        \ "autoload" : {"commands": ["Gist"]}}
  NeoBundleLazy 'thinca/vim-ref', {
        \ "autoload" : {"commands": ["Ref"]}}
  NeoBundleLazy 'vim-scripts/tComment', {
        \ "autoload" : {"mappings": ["<C-_><C-_>"]}}
  NeoBundleLazy 'sjl/gundo.vim', {
        \ "autoload" : {"commands": ["GundoToggle"]}}
  NeoBundleLazy 'mrtazz/simplenote.vim', {
        \ "autoload" : {"commands": ["Simplenote"]}}
  NeoBundle 'vim-scripts/surround.vim'
  NeoBundleLazy 'maksimr/vim-translator', {
        \ "autoload" : {"mappings": ["<plug>TranslateBlockText"]}}
  NeoBundleLazy 'vim-scripts/errormarker.vim', {
        \ "autoload" : {"augroup": ["errormarker"]}}
  NeoBundleLazy 'trotter/autojump.vim.git', {
        \ "autoload" : {
        \   "commands": ["J"]
        \ },
        \ "build": {
        \   "mac": "brew install autojump"
        \ }}
  " NeoBundleLazy "vim-pandoc/vim-pandoc", {
  "     \ "autoload": {
  "     \   "filetypes": ["text", "pandoc", "markdown", "rst", "textile"],
  "     \ }}
  NeoBundleLazy "lambdalisue/shareboard.vim", {
      \ "autoload": {
      \   "commands": ["ShareboardPreview", "ShareboardCompile"],
      \ },
      \ "build": {
      \   "mac": "pip install shareboard",
      \   "unix": "pip install shareboard",
      \ }}
  NeoBundleLazy 'Shougo/neocomplete.vim', {
        \ "autoload": {"insert": 1}}
  NeoBundleLazy "Shougo/vimfiler", {
      \ "depends": ["Shougo/unite.vim"],
      \ "autoload": {
      \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
      \   "mappings": ['<Plug>(vimfiler_switch)'],
      \   "explorer": 1,
      \ }}
  NeoBundle 'mattn/webapi-vim'

  "fot Python
  NeoBundleLazy 'davidhalter/jedi-vim', {
        \ "autoload": {"filetypes": ['py']}}
  NeoBundleLazy 'kevinw/pyflakes-vim', {
        \ "autoload": {"filetypes": ['py']}}

  "for JavaScript
  NeoBundleLazy 'hallettj/jslint.vim', {
        \ "autoload": {"filetypes": ['js']}}
  NeoBundleLazy 'pangloss/vim-javascript', {
        \ "autoload": {"filetypes": ['js']}}

  "for CofeeScript
  NeoBundleLazy 'kchmck/vim-coffee-script', {
        \ "autoload": {"filetypes": ['coffee']}}

  "for TypeScript
  NeoBundle 'leafgarland/typescript-vim'

  "for TeX
  NeoBundleLazy 'jcf/vim-latex', {
        \ "autoload": {"filetypes": ['tex']}}

  "for HTML
  NeoBundleLazy 'mattn/emmet-vim', {
        \ "autoload": {"filetypes": ['html']}}
  NeoBundleLazy 'othree/html5.vim', {
        \ "autoload": {"filetypes": ['html']}}
  NeoBundleLazy 'cakebaker/scss-syntax.vim.git', {
        \ "autoload": {"filetypes": ['sass']}}
  NeoBundleLazy 'hail2u/vim-css3-syntax.git', {
        \ "autoload": {"filetypes": ['css']}}

  "for Scala
  NeoBundleLazy 'derekwyatt/vim-scala.git', {
        \ "autoload": {"filetypes": ['scala']}}

  "for Lua
  NeoBundleLazy 'lua-support', {
        \ "autoload": {"filetypes": ['lua']}}

  "for Puppet
  NeoBundleLazy 'rodjek/vim-puppet', {
        \ "autoload": {"filetypes": ['puppet']}}

  "for Groovy
  NeoBundleLazy 'groovy.vim', {
        \ "autoload": {"filetypes": ['groovy']}}

  "for MoonScript
  NeoBundleLazy 'leafo/moonscript-vim', {
        \ "autoload": {"filetypes": ['moon']}}

  "for restructuredText
  NeoBundleLazy 'mattn/mkdpreview-vim', {
        \ "autoload": {"filetypes": ['rst']}}

  "for GLSL
  NeoBundleLazy 'tikhomirov/vim-glsl', {
        \ "autoload": {"filetypes": ['vert', 'frag', 'fp', 'vp', 'glsl']}}

  NeoBundleCheck
endif

filetype plugin indent on
