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

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
setopt prompt_subst

# Ref http://d.hatena.ne.jp/seiunsky/20110519/1305764493
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

# Autojump settings
PATH=$HOME/.autojump/bin:$PATH
[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh

# show vcs branch info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' max-exports 6 
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b@%r' '%c' '%u'
zstyle ':vcs_info:git:*' actionformats '%b@%r|%a' '%c' '%u'
setopt prompt_subst
function vcs_echo {
    local st branch color
    STY= LANG=en_US.UTF-8 vcs_info
    st=`git status 2> /dev/null`
    if [[ -z "$st" ]]; then return; fi
    branch="$vcs_info_msg_0_"
    if   [[ -n "$vcs_info_msg_1_" ]]; then color=${fg[green]} #staged
    elif [[ -n "$vcs_info_msg_2_" ]]; then color=${fg[red]} #unstaged
    elif [[ -n `echo "$st" | grep "^Untracked"` ]]; then color=${fg[blue]} # untracked
    else color=${fg[cyan]}
    fi
    echo "%{$color%}(%{$branch%})%{$reset_color%}" | sed -e s/@/"%F{yellow}@%f%{$color%}"/
}
PROMPT='
%F{yellow}[%~]%f `vcs_echo`
%(?.$.%F{red}$%f) '

# Show current directory on Finder
function showFinder(){
  open `pwd`
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

## ls
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
alias gls="gls --color"
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

alias -s txt=less
alias -s rb=ruby
alias -s pl=perl
alias ls="ls -a -G -l"
alias rm="rm -i"
alias vim=nvim

#zsh syntax highlighting
if [ -f ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

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

#Setting for hub
# hub alias -s zsh
alias git=hub
if type compdef >/dev/null; then
   compdef hub=git
fi

# setup perlbrew
if [ -f "~/perl5" ];
then
  source ~/perl5/perlbrew/etc/bashrc
fi

#Settings for tmux-powerline
PROMPT="$PROMPT"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

fpath=(/usr/local/share/zsh/site-functions/ ${fpath})
autoload -U compinit; compinit -u

# Settings for homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# Settings for go lang
if [ -x "`which go`" ]; then
  export GOROOT=`go env GOROOT`
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

# Settings for Gibo
source ~/.gibo-completion.zsh

# http://qiita.com/laiso/items/8a30e3656c980863ccfa
propen() {
  local current_branch_name=$(git symbolic-ref --short HEAD | xargs perl -MURI::Escape -e 'print uri_escape($ARGV[0]);')
  hub browse -- pull/${current_branch_name}
}

# added by travis gem
[ -f /Users/giginet/.travis/travis.sh ] && source /Users/giginet/.travis/travis.sh

# direnv
eval "$(direnv hook zsh)"

# Load peco functions
[ -f ~/.zshrc.peco ] && source ~/.zshrc.peco


source "$HOME/.peco-anyenv/peco-anyenv.sh"
