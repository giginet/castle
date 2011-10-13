let g:quickrun_config.coffee = {
\  'command' : 'coffee'
\}
autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!
