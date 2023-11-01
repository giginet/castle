#!/usr/bin/env bash

modifier="#[bg=${green},fg=${dark_gray}]"
pane_current_path="$1"

if [[ "$pane_current_path" == $HOME ]]; then
  pwd_status="󰋜"
else
  pwd_status=" #{s|^$HOME|~|:pane_current_path}"
fi

git_modifier="#[bg=${orange},fg=${dark_gray}]"
is_git_repository=`git -C $pane_current_path rev-parse --is-inside-work-tree`

if [[ "$?" == 0 ]]; then
  current_branch=`git -C $pane_current_path rev-parse --abbrev-ref HEAD`
  git_status=" $current_branch"
else
  current_branch=`git -C $pane_current_path rev-parse --abbrev-ref HEAD`
  git_status=""
fi
echo "${modifier} ${pwd_status} ${git_modifier} ${git_status} "
