#補完周り
autoload -U compinit
compinit
autoload predict-on
predict-on
setopt list_packed
setopt auto_pushd
setopt auto_cd
setopt auto_list
setopt auto_menu
## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
setopt correct
setopt prompt_subst
#scp補完無効
zstyle ':completion:*:complete:scp:*:files' command command -
#コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt share_history
setopt append_history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
#環境変数
export PATH=/usr/bin/android-sdk-mac_86/tools:/opt/local/lib:/opt/local/bin:/opt/local/sbin/:$PATH
export MANPATH=/opt/local/man:$MANPATH

bindkey -v
setopt multios #複数リダイレクト有効
#色の設定
autoload colors
colors
## lsをカラー化
export LSCOLORS=exfxcxdxbxegedabagacad
alias ls="ls -G -l"

#alias
alias -s txt=less
alias -s py=python
alias -s rb=ruby
##PythonSelect
alias python_select26="sudo port select --set python python26"
alias python_select27="sudo port select --set python python27"
