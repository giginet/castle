"QuickRun.vim
let g:quickrun_config = { 
\ 'tex' : {
\   'command' : 'platex-utf8',
\   'exec'    : ['%c -output-directory %s:h %s', 'dvipdfmx -o %s:r.pdf %s:r.dvi', 'open %s:r.pdf'],
\   'output'  : '_'
\ }
\}

