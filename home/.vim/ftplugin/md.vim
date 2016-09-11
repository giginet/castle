set tabstop=4
set shiftwidth=4
if dein#tap('vim-quickrun')
  let g:quickrun_config = {}
  let g:quickrun_config.md = {
        \ 'outputter' : 'null',
        \ 'command'   : 'open',
        \ 'cmdopt'    : '-a',
        \ 'args'      : 'Marked\ 2',
        \ 'exec'      : '%c %o %a %s',
        \ }
endif
noremap <C-t> :TableModeToggle<CR>
noremap ``` :InlineEdit<CR>
