let s:hooks = neobundle#get_hooks("previm")
function! s:hooks.on_source(bundle)
  g:previm_open_cmd = 'open -a Google Chrome'
  noremap <C-x> :PrevimOpen
endfunction
