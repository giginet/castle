setl autoindent
setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,clas
setl tabstop=8 expandtab shiftwidth=4 softtabstop=4
set expandtab
autocmd BufNewFile *.py 0r $HOME/.vim/template/python.py
"Pydictionの設定有効化
"autocmd FileType python let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'
Bundle 'Pydiction'
