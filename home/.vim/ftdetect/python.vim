if !exists('g:flymake_enabled')
  let g:flymake_enabled = 1
  autocmd BufWritePost *.py silent make
endif
