# peco
function exists { which $1 &> /dev/null }

if exists peco; then
  function phistory() {
    local tac
    if which tac > /dev/null; then
      tac="tac"
    else
      tac="tail -r"
    fi
    BUFFER=$(history -n 1 | eval $tac | awk '!a[$0]++' | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
  }
  zle -N phistory
  bindkey '^r' phistory

  function pj() {
    cd $(j -s | awk '{ print $2 }' | awk '/^\//' | peco)
  }
  zle -N pj
  bindkey '^j' pj

  prake() { local task=$(rake -W | peco | cut -d " " -f 2); rake $task }

  function ppgrep() {
    if [[ $1 == "" ]]; then
    PECO=peco
    else
    PECO="peco --query $1"
    fi
    ps aux | eval $PECO | awk '{ print $2 }'
  }

  function ppkill() {
    if [[ $1 =~ "^-" ]]; then
      QUERY=""            # options only
    else
      QUERY=$1            # with a query
      [[ $# > 0 ]] && shift
    fi
    ppgrep $QUERY | xargs kill $*
  }

  function pghq () {
    local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    echo $selected_dir
    cd $selected_dir
  }

  function pirkit () {
    irkit -list | ruby -e '$stdin.readlines.each{|line| break if line.start_with?("== Devices");next if line.start_with?("~");next if line.start_with?("=");puts line;}' | peco | xargs -I{} irkit --post {} --device IRKit0
  }

  function pco {
    git checkout `git branch | peco | sed -e "s/\* //g" | awk "{print \$1}"`
  }

  function pag () {
    vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
  }

  function pspec () {
    git ls-files spec | peco | xargs bundle exec rspec
  }
  function pcdr () {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
  }
  zle -N pcdr
  bindkey '^h' pcdr

  function pvim() {
    vim $(find . | peco)
  }

fi
