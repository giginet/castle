let s:hooks = neobundle#get_hooks("previm")
function! s:hooks.on_source(bundle)
  let g:previm_open_cmd = "open -a 'Google Chrome'"
	let g:previm_disable_default_css = 1
  noremap <C-x> :PrevimOpen<CR>
endfunction
