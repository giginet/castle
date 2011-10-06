autocmd BufNewFile *.py 0r ~/.vim/templates/python.py
autocmd FileType python compiler pylint
autocmd FileType python setlocal omnifunc=pysmell#Complete

if !exists('g:flymake_enabled')
  let g:flymake_enabled = 1
  autocmd BufWritePost *.py silent make
endif
