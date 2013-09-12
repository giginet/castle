let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)
  let g:quickrun_config.coffee = {
        \  'command' : 'coffee'
        \}
endfunction

function! Cake()
  if filereadable('Cakefile')
    call system("cake compile") | cwindow | redraw!
  else
    silent CoffeeMake! -cb | cwindow | redraw!
  endif
endfunction
noremap <C-c> :call Cake()<CR>
