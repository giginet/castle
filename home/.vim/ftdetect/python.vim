autocmd BufNewFile *.py 0r ~/.vim/templates/python.py
" autocmd FileType python set omnifunc=pythoncomplete#Complete

if !exists('g:flymake_enabled')
  let g:flymake_enabled = 1
  autocmd BufWritePost *.py silent make
endif

"Insert Signature
function! InsertSignature()
  let filename = expand('%')
  let date = strftime("%Y/%m/%d")
  let user = $USER
  call append(1, '#')
  call append(2, printf('# %s', filename))
  call append(3, printf('# created by %s on %s', user, date))
  call append(4, '#')
  call cursor('$', 0)
endfunction
autocmd BufNewFile *.py call InsertSignature()

