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
  NeoBundle "wakatime/vim-wakatime"
  NeoBundleLazy "thinca/vim-quickrun", {
        \ "autoload": {
        \   "mappings": [['nxo', '<Plug>(quickrun)']]
        \ }}
  NeoBundleLazy "Shougo/unite.vim", {
      \ "autoload": {
      \   "commands": ["Unite", "UniteWithBufferDir"]
      \ }}
  NeoBundleLazy 'lambdalisue/vim-gista', {
    \ 'autoload': {
    \    'commands': ['Gista'],
    \    'mappings': '<Plug>(gista-',
    \    'unite_sources': 'gista',
    \}}
  NeoBundleLazy 'vim-scripts/tComment', {
        \ "autoload" : {"mappings": ["<C-_><C-_>"]}}
  NeoBundleLazy 'sjl/gundo.vim', {
        \ "autoload" : {"commands": ["GundoToggle"]}}
  NeoBundleLazy 'mrtazz/simplenote.vim', {
        \ "autoload" : {"commands": ["Simplenote"]}}
  NeoBundleLazy 'vim-scripts/errormarker.vim', {
        \ "autoload" : {"augroup": ["errormarker"]}}
  NeoBundleLazy "Shougo/vimfiler", {
      \ "depends": ["Shougo/unite.vim"],
      \ "autoload": {
      \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
      \   "mappings": ['<Plug>(vimfiler_switch)'],
      \   "explorer": 1,
      \ }}
  NeoBundleLazy 'airblade/vim-gitgutter', {
        \ "autoload": {"insert": 1}}
  NeoBundleLazy 'rhysd/wandbox-vim', {
        \ "autoload": {"insert": 1}}
  NeoBundleLazy 'rhysd/wandbox-vim', {
        \ "autoload": {'commands': ["Wandbox"]}}
  NeoBundleLazy 'keith/investigate.vim', {
        \ "autoload": {'mappings': ["gK"]}}
  if has('nvim')
    NeoBundleLazy 'Shougo/deoplete.nvim', {
          \ "autoload": {"insert": 1}}
  else
    NeoBundleLazy 'Shougo/neocomplete.vim', {
          \ "autoload": {"insert": 1}}
  endif

  "fot Python
  NeoBundleLazy 'davidhalter/jedi-vim', {
        \ "autoload": {"filetypes": ['py']}}
  NeoBundleLazy 'kevinw/pyflakes-vim', {
        \ "autoload": {"filetypes": ['py']}}
  
  "for Ruby
  NeoBundleLazy 'basyura/unite-rails', {
        \ 'depends' : 'Shougo/unite.vim',
        \ 'autoload' : {
        \   'unite_sources' : [
        \     'rails/bundle', 'rails/bundled_gem', 'rails/config',
        \     'rails/controller', 'rails/db', 'rails/destroy', 'rails/features',
        \     'rails/gem', 'rails/gemfile', 'rails/generate', 'rails/git', 'rails/helper',
        \     'rails/heroku', 'rails/initializer', 'rails/javascript', 'rails/lib', 'rails/log',
        \     'rails/mailer', 'rails/model', 'rails/rake', 'rails/route', 'rails/schema', 'rails/spec',
        \     'rails/stylesheet', 'rails/view'
        \   ]
        \ }}

  "for JavaScript
  NeoBundleLazy 'pangloss/vim-javascript', {
        \ "autoload": {"filetypes": ['js']}}

  "for CofeeScript
  NeoBundleLazy 'kchmck/vim-coffee-script', {
        \ "autoload": {"filetypes": ['coffee']}}

  "for TypeScript
  NeoBundleLazy 'leafgarland/typescript-vim', {
        \ "autoload": {"filetypes": ['ts']}}

  "for HTML
  NeoBundleLazy 'othree/html5.vim', {
        \ "autoload": {"filetypes": ['html']}}
  NeoBundleLazy 'cakebaker/scss-syntax.vim.git', {
        \ "autoload": {"filetypes": ['sass']}}
  NeoBundleLazy 'hail2u/vim-css3-syntax.git', {
        \ "autoload": {"filetypes": ['css']}}

  "for Swift
  NeoBundleLazy 'toyamarinyon/vim-swift', {
        \ "autoload": {"filetypes": ['swift']}}

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
  NeoBundleLazy 'tfnico/vim-gradle', {
        \ "autoload": {"filetypes": ['gradle']}}

  "for MoonScript
  NeoBundleLazy 'leafo/moonscript-vim', {
        \ "autoload": {"filetypes": ['moon']}}

  "for restructuredText
  NeoBundleLazy 'kannokanno/previm', {
        \ "autoload": {"filetypes": ['rst', 'md']}}
  NeoBundleLazy 'vim-scripts/rest.vim', {
        \ "autoload": {"filetypes": ['rst']}}

  "for GLSL
  NeoBundleLazy 'tikhomirov/vim-glsl', {
        \ "autoload": {"filetypes": ['vert', 'frag', 'fp', 'vp', 'glsl']}}

  "for Markdown
  NeoBundleLazy 'AndrewRadev/inline_edit.vim', {
        \ "autoload": {"filetypes": ['md']}}
  NeoBundleLazy 'dhruvasagar/vim-table-mode', {
        \ "autoload": {"filetypes": ['md']}}
  
  "for Haskell
  NeoBundleLazy 'dag/vim2hs', {
        \ "autoload": {"filetypes": ['hs']}}
  NeoBundleLazy 'eagletmt/neco-ghc', {
        \ "autoload": {"filetypes": ['hs']}}
  NeoBundleLazy 'eagletmt/ghcmod-vim', {
        \ "autoload": {"filetypes": ['hs']}}

  " for Octave
  NeoBundleLazy 'jvirtanen/vim-octave', {
        \ "autoload": {"filetypes": ['octave']}}
  " for TOML
  NeoBundleLazy 'cespare/vim-toml', {
        \ "autoload": {"filetypes": ['toml']}}

  NeoBundleCheck
endif

filetype plugin indent on
