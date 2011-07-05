function! CommentOut()
  "comment type # 
  if &l:filetype ==# 'perl' || &l:filetype ==# 'ruby' || &l:filetype ==#
    'sh' || &l:filetype ==# 'yaml'
    if getline('.') =~ '^\s*#'
      s/^\(\s*\)#\+ \?/\1/
    else  
      s/^\s*/\0# /
    endif

    "comment type //
  elseif &l:filetype ==# 'javascript'
    if getline('.') =~ '^\s*\/\/'
      s/^\(\s*\)\/\/\+ \?/\1/
    else
      s/^\s*/\0\/\/ /
    endif

    "comment type 
  elseif
    &l:filetype
    ==# 'vim'
    if
      getline('.')
      =~ '^\s*'
      s/^\(\s*\)\+
            \?/\1/
    else  
      s/^\s*/\0
      /
    endif


    "comment
    "type
    "'
    s/^\(\s*\)/\1\2/
  else
    s/^\(\s*\)\(.*\)$/\1/
  endif


  "other
else
  if
    getline('.')
    =~
    '^\s*\/\/'
    s/^\(\s*\)\/\/\+
          \?/\1/
  else
    s/^\s*/\0\/\/
    /
  endif
endif
:nohlsearch
endf                                                                                                                                           endf

