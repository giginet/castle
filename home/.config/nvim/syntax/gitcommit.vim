" Vim syntax file
" Language:	git commit file
" Filenames:	*.git/COMMIT_EDITMSG

if exists("b:current_syntax")
  finish
endif

syn case match
syn sync minlines=50

if has("spell")
  syn spell toplevel
endif

syn include @gitcommitDiff syntax/diff.vim
syn region gitcommitDiff start=/\%(^diff --\%(git\|cc\|combined\) \)\@=/ end=/^\%(diff --\|$\|#\)\@=/ fold contains=@gitcommitDiff

syn match gitcommitComment	"^#.*"

hi def link gitcommitComment		Comment

let b:current_syntax = "gitcommit"
