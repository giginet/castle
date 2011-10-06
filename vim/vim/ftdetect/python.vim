autocmd BufNewFile *.py 0r ~/.vim/templates/python.py
autocmd FileType python compiler pylint
autocmd FileType python setlocal omnifunc=pysmell#Complete
