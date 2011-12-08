let g:quickrun_config.coffee = {
\  'command' : 'coffee'
\}

function! Cake()
  if filereadable('Cakefile')
    call system("cake compile") | cwindow | redraw!
  else
    silent CoffeeMake! -cb | cwindow | redraw!
  endif
endfunction
"autocmd BufWritePost *.coffee call Cake()
