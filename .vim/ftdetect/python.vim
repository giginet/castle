"Pydictionの設定有効化
Bundle 'Pydiction'
let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'
autocmd BufNewFile *.py 0r ~/.vim/templates/python.py
autocmd BufNewFile *.py call InsertSignature()
