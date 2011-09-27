autocmd BufNewFile *.py 0r ~/.vim/templates/python.py

Bundle 'PySmell'
Bundle 'pylint.vim'
autocmd FileType python setlocal omnifunc=pysmell#Complete
let g:pysmell_debug=1

autocmd FileType python compiler pylint
