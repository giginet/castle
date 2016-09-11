"インデント周りの設定
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set shiftround

"Quickrun
let s:hooks = dein#tap("vim-quickrun")
function! s:hooks.on_source(bundle)
  let g:quickrun_config.js = {
  \ 'command' : 'node',
  \ 'exec'    : '%c %o %s %a'
  \}
endfunction

"jslint.vim
"ref : http://blog.monoweb.info/article/2011042918.html
if dein#tap("jslint.vim")
  autocmd FileType javascript call s:javascript_filetype_settings()
  let g:JSLintHighlightErrorLine = 1
endif
function! s:javascript_filetype_settings()
  autocmd BufLeave     <buffer> call jslint#clear()
  autocmd BufWritePost <buffer> call jslint#check()
  autocmd CursorMoved  <buffer> call jslint#message()
endfunction


