autocmd BufNewFile *.py 0r ~/.vim/templates/python.py
autocmd FileType python compiler pylint
autocmd FileType python setlocal omnifunc=pysmell#Complete

"pylint
setlocal makeprg=$PYTHONPATH/../bin/pylint\ --rcfile=$HOME/.pylint\ -e\ %
setlocal errorformat=%t:%l:%m

if !exists('g:flymake_enabled')
  let g:flymake_enabled = 1
  autocmd BufWritePost *.py silent make
endif
