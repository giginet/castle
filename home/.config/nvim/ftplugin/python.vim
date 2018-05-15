filetype on
setl autoindent
setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
setl tabstop=4 expandtab shiftwidth=4 softtabstop=4
set expandtab

"ropevim
let ropevim_vim_completion=1
let ropevim_extended_complete=1

"pep8
let g:pep8_map='<Leader>8'

if dein#tap('deoplete-jedi')
  let g:jedi#completions_enabled = 1
endif