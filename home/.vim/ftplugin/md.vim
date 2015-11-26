set tabstop=4
set shiftwidth=4
let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)
  let g:quickrun_config = {}
  let g:quickrun_config.md = {
        \ 'outputter' : 'null',
        \ 'command'   : 'open',
        \ 'cmdopt'    : '-a',
        \ 'args'      : 'Marked\ 2',
        \ 'exec'      : '%c %o %a %s',
        \ }
endfunction
noremap <C-t> :TableModeToggle<CR>
noremap ``` :InlineEdit<CR>
