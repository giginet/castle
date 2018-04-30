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

if dein#tap('vim-markdown')
  let g:vim_markdown_folding_disabled = 1
endif

noremap <C-t> :TableModeToggle<CR>
noremap ``` :InlineEdit<CR>
