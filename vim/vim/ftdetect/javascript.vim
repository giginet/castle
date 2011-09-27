"jqueryのSyntax適応
au BufRead,BufNewFile *.js set ft=javascript syntax=javascript
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

"jslint
Bundle 'basyura/jslint.vim'

"jslint.vim
"ref : http://blog.monoweb.info/article/2011042918.html
function! s:javascript_filetype_settings()
  autocmd BufLeave     <buffer> call jslint#clear()
  autocmd BufWritePost <buffer> call jslint#check()
  autocmd CursorMoved  <buffer> call jslint#message()
endfunction
autocmd FileType javascript call s:javascript_filetype_settings()
let g:JSLintHighlightErrorLine = 1
