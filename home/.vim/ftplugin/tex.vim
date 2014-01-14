"QuickRun.vim
let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)
  let g:quickrun_config.tex = {
  \ 'command' : 'platex',
  \ 'exec'    : ['%c -output-directory %s:h %s', 'dvipdfmx -o %s:r.pdf %s:r.dvi', 'open %s:r.pdf'],
  \ 'split': '{"rightbelow 10sp"}'
  \}
endfunction
