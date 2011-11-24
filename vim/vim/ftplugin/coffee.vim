let g:quickrun_config.coffee = {
\  'command' : 'coffee'
\}

function! Cake()
  if filereadable('Cakefile')
    let result = system("cake compile")
    echo result
  else
    silent CoffeeMake! -cb | cwindow | redraw!
  endif
endfunction
autocmd BufWritePost *.coffee call Cake()
