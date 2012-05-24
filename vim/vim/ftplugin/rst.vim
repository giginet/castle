let g:quickrun_config['rst'] = {
\ 'command': 'rst2html.py',
\ 'exec'    : ['%c %s > %s:r.html', 'open %s:r.html'],
\ 'split': '{"rightbelow 10sp"}'
\}
