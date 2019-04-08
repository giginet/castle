set tabstop=4
set shiftwidth=4
if dein#tap('vim-quickrun')
  let g:quickrun_config = {}
  let g:quickrun_config.markdown = {
        \ 'outputter' : 'null',
        \ 'command'   : 'open',
        \ 'cmdopt'    : '-a',
        \ 'args'      : 'Marked\ 2',
        \ 'exec'      : '%c %o %a %s',
        \ }
endif
