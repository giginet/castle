let g:quickrun_config['rst'] = {
\ 'command': 'pandoc',
\ 'exec'    : ['%c %s -s -o %s:r.html', 'open %s:r.html'],
\ 'split': '{"rightbelow 10sp"}'
\}
