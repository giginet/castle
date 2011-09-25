" Run commands quickly.
" Version: 0.4.7
" Author : thinca <thinca+vim@gmail.com>
" License: Creative Commons Attribution 2.1 Japan License
"          <http://creativecommons.org/licenses/by/2.1/jp/deed.en>

if exists('g:loaded_quickrun')
  finish
endif
let g:loaded_quickrun = 1

let s:save_cpo = &cpo
set cpo&vim

" MISC Functions. {{{1
" ----------------------------------------------------------------------------
" Function for |g@|.
function! QuickRun(mode)  " {{{2
  execute 'QuickRun -mode o -visualmode' a:mode
endfunction


command! -nargs=* -range=% -complete=customlist,quickrun#complete QuickRun
\ call quickrun#command('-start <line1> -end <line2> ' . <q-args>)


nnoremap <silent> <Plug>(quickrun-op) :<C-u>set operatorfunc=QuickRun<CR>g@

nnoremap <silent> <Plug>(quickrun) :<C-u>QuickRun -mode n<CR>
vnoremap <silent> <Plug>(quickrun) :<C-u>QuickRun -mode v<CR>

" Default key mappings.
if !hasmapto('<Plug>(quickrun)')
\  && (!exists('g:quickrun_no_default_key_mappings')
\      || !g:quickrun_no_default_key_mappings)
  silent! map <unique> <Leader>r <Plug>(quickrun)
endif

let &cpo = s:save_cpo
unlet s:save_cpo
