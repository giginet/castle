"jqueryのSyntax適応
au BufRead,BufNewFile *.js set ft=javascript syntax=javascript
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

"compress js on each saved via YUI Compressor.
"ref : https://github.com/othree/fecompressor.vim
"function CompressJS ()
"    let cwd = system('pwd')
"    let nam = expand('%:r')
"    let ext = expand('%:e')
"    if ext == 'js'
"        if -1 == match(nam, "[\._]src$")
"            let minfname = nam.".min.".ext
"        else
"            let minfname = substitute(nam, "[\._]src$", "", "g").".".ext
"        endif
"        echo 'yuicompressor '.cwd.'/'.nam.'.'.ext.' -o '.cwd.'/'.minfname
"        call system( 'yuicompressor '.cwd.'/'.nam.'.'.ext.' -o '.cwd.'/'.minfname)
"    endif
"endfunction
"autocmd BufWritePost *.js :call CompressJS()
