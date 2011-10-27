filetype on
setl autoindent
setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
setl tabstop=4 expandtab shiftwidth=4 softtabstop=4
set expandtab

"pylint
set makeprg=$PYTHONPATH/pylint\ --rcfile=$HOME/.pylint\ -r=n\ %:p
set errorformat=%f:%l:\ %m

"ropevim
let ropevim_vim_completion=1
let ropevim_extended_complete=1

"pysmell
let g:pysmell_matcher='camel-case' 
let g:pysmell_debug=1

"pep8
let pep8_map='<Leader>8'
