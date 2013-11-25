"インデント周りの設定
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set shiftround

"Quickrun
let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)
  let g:quickrun_config.js = {
  \ 'command' : 'node',
  \ 'exec'    : '%c %o %s %a'
  \}
endfunction

"jslint.vim
"ref : http://blog.monoweb.info/article/2011042918.html
let s:hooks = neobundle#get_hooks("jslint.vim")
function! s:hooks.on_source(bundle)
  autocmd FileType javascript call s:javascript_filetype_settings()
  let g:JSLintHighlightErrorLine = 1
endfunction
function! s:javascript_filetype_settings()
  autocmd BufLeave     <buffer> call jslint#clear()
  autocmd BufWritePost <buffer> call jslint#check()
  autocmd CursorMoved  <buffer> call jslint#message()
endfunction


