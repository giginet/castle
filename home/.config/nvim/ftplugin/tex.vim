"QuickRun.vim
if dein#tap("vim-quickrun")
  let g:quickrun_config.tex = {
  \ 'command' : 'platex',
  \ 'exec'    : ['%c -output-directory %s:h %s', 'dvipdfmx -o %s:r.pdf %s:r.dvi', 'open %s:r.pdf'],
  \ 'split': '{"rightbelow 10sp"}'
  \}
endif
