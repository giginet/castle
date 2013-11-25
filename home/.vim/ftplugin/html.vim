let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)
  let g:quickrun_config.html = {
  \  'command' : 'open'
  \}
endfunction
