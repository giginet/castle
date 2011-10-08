autocmd BufNewFile *.py 0r ~/.vim/templates/python.py
autocmd FileType python compiler pylint
autocmd FileType python setlocal omnifunc=pysmell#Complete

"pylint
set makeprg=$PYTHONPATH/pylint\ --rcfile=$HOME/.pylint\ -r=n\ %:p
set errorformat=%f:%l:\ %m

if !exists('g:flymake_enabled')
  let g:flymake_enabled = 1
  "autocmd BufWritePost *.py silent make
endif
