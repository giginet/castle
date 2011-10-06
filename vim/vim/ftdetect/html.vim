autocmd BufNewFile *.html 0r ~/.vim/templates/html.html

let g:use_zen_complete_tag = 1
setlocal omnifunc=zencoding#CompleteTag

"Setting zen-coding
let g:user_zen_settings = {
      \'indentation' : '  ',
\}
