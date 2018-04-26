# Load Local Settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Completion Settings
setopt always_last_prompt
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt list_packed
setopt list_types
setopt auto_remove_slash
setopt auto_param_slash
setopt mark_dirs
setopt complete_in_word
setopt magic_equal_subst
setopt hist_verify
unsetopt list_beep
unsetopt menu_complete
unsetopt list_rows_first
unsetopt complete_aliases
unsetopt correct_all
zstyle ':completion:*:default' list-colors ${LS_COLORS}

# enable cdr
autoload -Uz add-zsh-hock
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
setopt prompt_subst

# When zplug checking is disabled
# You have to execute `zplug install && zplug load` manually
ENABLE_INCREMENTAL_COMPLETION=0
if [ $ENABLE_INCREMENTAL_COMPLETION = 1 ] ;
then
  source $HOME/.incr.zsh
fi

# Ignore completion on scp
zstyle ':completion:*:complete:scp:*:files' command command -

# Other Settings
bindkey -v
setopt multios
setopt autopushd
setopt PUSHD_IGNORE_DUPS
setopt auto_cd
setopt pushd_ignore_dups

# History Settings
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt bang_hist
setopt extended_history
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_no_store
setopt append_history
setopt share_history
unsetopt hist_ignore_all_dups
unsetopt hist_expire_dups_first
unsetopt hist_save_no_dups

#auto ls
function chpwd() { ls -a }

# cd .. with ^^
function cdup(){
  echo
  cd ..
  zle reset-prompt
 }
 zle -N cdup
 bindkey '\^\^' cdup

function git-root() {
  cd `git rev-parse --show-toplevel`
}

# Show current directory on Finder
function showFinder(){
  open -R `pwd`
}
zle -N showFinder
bindkey '^f' showFinder

# Environment Variable Settings
export PATH=/usr/local/share/npm/bin:/usr/texbin:$HOME/.bin:/usr/local/bin:/Applications/Android/sdk/platform-tools:$HOME/Library/Haskell/bin:$PATH
export EDITOR=$(brew --prefix)/bin/nvim

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export XDG_CONFIG_HOME=$HOME/.config

# Color Settings
autoload -U colors
colors

alias ls="ls -a -G -l"
alias rm="rm -i"
alias vim=nvim

#for Python Development
PYENV_ROOT=$HOME/.pyenv
PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

#for Ruby Development
PATH=$HOME/.rbenv/bin:$PATH
PATH=$HOME/.rbenv/shims:$PATH # Add rbenv to PATH
alias be="bundle exec"

#for Node Development
if [[ -f ~/.nodebrew/nodebrew ]]; then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
fi

# for swiftenv
if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi

source "$HOME/.pyenv/versions/3.6.1/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh"

if [[ -z "$TMUX" ]]
then
  tmux new-session;
  exit;
fi

# zplug
ENABLE_ZPLUG_CHECKING=0
if [ -f $HOME/.zplug/init.zsh ]; then
  source $HOME/.zplug/init.zsh

  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  zplug "giginet/peco-anyenv"
  zplug "simonwhitaker/gibo", lazy:true, use:'gibo', as:command
  zplug "b4b4r07/enhancd", lazy:true, use:'enhancd', as:command
  zplug "glidenote/hub-zsh-completion"
  zplug "dracula/zsh", as:theme
  zplug "iam4x/zsh-iterm-touchbar"
  zplug "iamthememory/homesick-zsh-completion"

  if [ $ENABLE_ZPLUG_CHECKING = 1 ] ; then 
    if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
        echo; zplug install
      fi
    fi
  fi

  zplug load
else
  echo 'zplug is not installed'
  echo "Execute 'curl -sL zplug.sh/installer | zsh'"
fi

# Autojump settings
[ -f `brew --prefix`/etc/profile.d/autojump.sh ] && . `brew --prefix`/etc/profile.d/autojump.sh

# zsh syntax highlighting
if [ -f ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Setting for hub
# hub alias -s zsh
alias git=hub
if type compdef >/dev/null; then
   compdef hub=git
fi

fpath=(/usr/local/share/zsh/site-functions/ ${fpath})
# Run compinit if zplug comp file hasn't load
if (( ! $+functions[_zplug] )); then
  compinit
fi

# Settings for homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

# Settings for go lang
if [ -x "`which go`" ]; then
  export GOROOT=`go env GOROOT`
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
  export GOROOT_BOOTSTRAP=$GOROOT
fi

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# direnv
eval "$(direnv hook zsh)"

# Load peco functions
[ -f ~/.peco-functions.zsh ] && source ~/.peco-functions.zsh

# JDK
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
export ANDROID_HOME=$HOME/Library/Android/sdk
