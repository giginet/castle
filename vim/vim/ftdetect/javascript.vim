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

"compress js on each saved via YUI Compressor.
"ref : https://github.com/othree/fecompressor.vim
function CompressJS ()
    let cwd = system('pwd')
    let nam = expand('%:r')
    let ext = expand('%:e')
    if ext == 'js'
        if -1 == match(nam, "[\._]src$")
            let minfname = nam.".min.".ext
        else
            let minfname = substitute(nam, "[\._]src$", "", "g").".".ext
        endif
        echo 'yuicompressor '.cwd.'/'.nam.'.'.ext.' -o '.cwd.'/'.minfname
        call system( 'yuicompressor '.cwd.'/'.nam.'.'.ext.' -o '.cwd.'/'.minfname)
    endif
endfunction

function Css_compress ()
    let cwd = expand('pwd')
    let nam = expand('%:r')
    let ext = "css"
    if -1 == match(nam, "[\._]src$")
        let minfname = nam.".min.".ext
    else
        let minfname = substitute(nam, "[\._]src$", "", "g").".".ext
    endif
    let com = 'yuicompressor '.cwd.'/'.nam.'.'.ext.' -o '.cwd.'/'.minfname.' &'
    "call system( 'yuicompressor '.cwd.'/'.nam.'.'.ext.' -o '.cwd.'/'.minfname.' &')
    call system(com)
endfunction

autocmd BufWritePost javascript call Css_compress()
