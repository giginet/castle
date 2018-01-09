if dein#tap('vim-quickrun')
  let g:quickrun_config = {}
  let g:quickrun_config.swift = {
        \ 'command'   : 'xcrun',
        \ 'cmdopt'    : 'swift',
        \ 'exec'      : '%c %o %s',
        \ }
endif

if dein#tap('swift.vim')
  let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']
endif
