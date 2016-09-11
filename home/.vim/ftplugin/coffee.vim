if dein#tap("vim-quickrun")
  let g:quickrun_config.coffee = {
        \  'command' : 'coffee'
        \}
endif

function! Cake()
  if filereadable('Cakefile')
    call system("cake compile") | cwindow | redraw!
  else
    silent CoffeeMake! -cb | cwindow | redraw!
  endif
endfunction
noremap <C-c> :call Cake()<CR>
