#補完周り
setopt always_last_prompt       # 補完をしてもプロンプトの位置を変えない
setopt auto_list                # 補完候補が複数あるとき、自動でメニューをリストアップする
setopt auto_menu                # tab,^i で順次補完候補を補完
setopt auto_param_keys          # 変数名を補完する
setopt list_packed              # 補完候補を詰めて表示
setopt list_types               # 補完候補表示時にファイルの種類も表示する *, @, / などが付く
setopt auto_remove_slash        # ディレクトリの後でスペースを入力すると、ディレクトリの後ろに付くスラッシュを削除する
setopt auto_param_slash         # ディレクトリ名の補完で末尾に / を自動的に補完
setopt mark_dirs                # ファイル名展開でディレクトリにマッチすると / をつける
setopt complete_in_word         # 語の途中でもカーソル位置で補完
setopt magic_equal_subst        # --prefix=/usr などの = 以降も補完
setopt hist_verify              # ヒストリから呼び出したときに一度編集できるように
unsetopt list_beep              # 補完の時にベルを鳴らさない
unsetopt auto_pushd             # 移動したディレクトリを補完候補に
unsetopt menu_complete          # 補完候補が複数ある時、すぐに最初の候補を補完する
unsetopt list_rows_first        # 補完の表示順序を水平方向にする
unsetopt complete_aliases       # エイリアスには別の補完規則を適用する
unsetopt correct_all            # 引数についてもスペル修正を試みる(うっとおしい)
autoload -U compinit; compinit  # zshの補完機能を利用する
zstyle ':completion:*:default' list-colors ${LS_COLORS}

# 補完の時に大文字小文字を区別しない(但し、大文字を打った場合は小文字に変換しない)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# sudo も補完対象にする
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
# 補完候補は Emacs のキーバインドで選択
zstyle ':completion:*:default' menu select=1

## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
setopt correct
setopt prompt_subst
#scp補完無効
zstyle ':completion:*:complete:scp:*:files' command command -

#その他
bindkey -v
setopt multios #複数リダイレクト有効
setopt autopushd
setopt auto_cd
setopt auto_list
setopt auto_menu

#コマンド履歴
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt bang_hist                 # !を使ったヒストリ展開を利用する
setopt extended_history          # 履歴に開始/終了時刻を記録
setopt inc_append_history        # 履歴をインクリメンタルに追加
setopt hist_ignore_dups          # 同じコマンドを連続して実行したとき、1つしか記録しない
setopt hist_ignore_space         # スペースから始まるものはヒストリに追加しない
setopt hist_reduce_blanks        # ヒストリ記録時に余分なスペースを削除する
setopt hist_no_store             # history コマンドは記録しない
setopt append_history            # zsh 複数起動時 history ファイルを上書きせず追記
unsetopt share_history           # 複数のzshセッションでヒストリをリアルタイムで共有する
unsetopt hist_ignore_all_dups    # ヒストリ内に全く同じ行があれば、古い方を削除する
unsetopt hist_expire_dups_first  # 古いヒストリが削除されるとき、まったく同じ行があれば、それを削除する
unsetopt hist_save_no_dups       # ヒストリ記録時に、古いコマンドと同じものがあれば削除する

#環境変数
export PATH=/opt/local/lib/perl5/site_perl/5.12.3:/usr/bin/android-sdk-mac_86/tools:/opt/local/lib:/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/man:$MANPATH
export EDITOR=vi

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
alias python_select32="sudo port select --set python python32"
