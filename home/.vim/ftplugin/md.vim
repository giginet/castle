let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)
  let g:quickrun_config['md'] = {
  \ 'command': 'pandoc',
  \ 'exec'    : ['%c %s -s -o %s:r.html', 'open %s:r.html'],
  \ 'split': '{"rightbelow 10sp"}'
  \}
endfunction
