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

# Enable compinit
autoload -Uz compinit && compinit

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
setopt prompt_subst

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
function chpwd() { ls -a -G -l }

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

function mdopen() {
  open -a "Marked 2.app" $@
}

# Environment Variable Settings
export PATH=/usr/local/bin:$HOME/.nest/bin:$PATH

if [ -x "`which brew`" ]; then
  export BREW_PREFIX=$(brew --prefix)
fi
export EDITOR=$BREW_PREFIX/bin/nvim
PATH=$HOME/.bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config

# Color Settings
autoload -U colors
colors

alias ls="ls -a -G -l"
alias rm="rm -i"
alias vim=nvim
alias lz=lazygit
alias lg=lazygit

# Homebrew
if [[ -e "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

#for Python Development
PYENV_ROOT=$HOME/.pyenv
PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

#for Ruby Development
PATH=$HOME/.rbenv/bin:$PATH
PATH=$HOME/.rbenv/shims:$PATH # Add rbenv to PATH

#for Node Development
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# for Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

if [[ -z "$TMUX" ]] && [[ -x `which tmux` ]] && [[ -n "$ENABLE_TMUX" ]]
then
  tmux new-session;
  exit;
fi

source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autojump settings
AUTOJUMP_ROOT=$HOME/.autojump
if [ -e $AUTOJUMP_ROOT/etc/profile.d/autojump.sh ]; then
  [ -f $AUTOJUMP_ROOT/etc/profile.d/autojump.sh ] && . $AUTOJUMP_ROOT/etc/profile.d/autojump.sh
elif [ -e $BREW_PREFIX/etc/profile.d/autojump.sh ]; then
  [ -f $BREW_PREFIX/etc/profile.d/autojump.sh ] && . $BREW_PREFIX/etc/profile.d/autojump.sh
fi

# gh completion
if [ -x "`which gh`" ]; then
  eval "$(gh completion -s zsh)"
fi

# Show current directory on Finder
function showFinder() { open -R "`pwd`" }
zle -N showFinder
bindkey '^f' showFinder

function showGitHub() { git browse }
zle -N showGitHub
bindkey '^g' showGitHub

# Settings for homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($BREW_PREFIX/share/zsh/site-functions/
  $HOME/.homesick/repos/homeshick/completions 
  $HOME/.zsh/shell-completions
  ${fpath})

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
if [ -x "`which direnv`" ]; then
  eval "$(direnv hook zsh)"
fi

# Load peco functions
[ -f ~/.peco-functions.zsh ] && source ~/.peco-functions.zsh

# JDK
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
export ANDROID_HOME=$HOME/Library/Android/sdk

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Starship
if [[ -x `which starship` ]]; then
  eval "$(starship init zsh)"
  export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
else
  echo "Please install starship"
fi

# My Tools
source $HOME/.zsh/peco-anyenv/peco-anyenv.sh
PATH=$PATH:$HOME/.zsh/swift-toolchain-manager/bin:$HOME/.zsh/xcode-opener/bin

function highlight() { 
  pbpaste | pygmentize -l $1 -O style=monokai -f rtf | pbcopy 
  echo "Your clipboard is highlighted ✨"
}

function pingen() {
  ruby -e 'puts 4.times.map { (0...10).to_a.sample.to_s }.join'
}

# Alacritty
PATH=$PATH:/Applications/Alacritty.app/Contents/MacOS

# Wezterm
PATH=$PATH:/Applications/Wezterm.app/Contents/MacOS

# Mint
export MINT_PATH=$HOME/.mint
export MINT_LINK_PATH=$HOME/.mint/bin
export PATH=$PATH:$MINT_LINK_PATH

# swift package experimental-install
export PATH=$PATH:$HOME/.swiftpm/bin

# Docker
export PATH=$HOME/.docker/bin:$PATH

# Compile zshrc
if [ $HOME/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile $HOME/.zshrc
fi

# Copilot
alias suggest="gh copilot suggest"
alias explain="gh copilot explain"

# Add JetBrains Toolbox
PATH=$PATH:$HOME/Library/Application\ Support/JetBrains/Toolbox/scripts

# 1Password Integration
# https://developer.1password.com/docs/ssh
ONE_PASSWORD_AGENT=$HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
if [ -e "$ONE_PASSWORD_AGENT" ]; then;
  export SSH_AUTH_SOCK=$ONE_PASSWORD_AGENT
fi

alias cppwd="pwd | tr -d '\n' | pbcopy"

# Setting for Rancher Desktop
export PATH="$HOME/.rd/bin:$PATH"
