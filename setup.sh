path=$(cd $(dirname $0); pwd)

function yes_no {
  MSG=$1
  while :
  do
    echo -n "${MSG} y/N: "
    read ans
    case $ans in
      [yY]) return 1 ;;
    [nN]) return 0 ;;
    esac
  done
}

yes_no 'CAUTION : your dotfiles under $HOME will be replaced.'
if [ $? -eq 1 ]
then
  for dir in $(ls -l | awk '$1 ~ /d/ {print $9 }')
  do
    for file in $(ls $dir)
    do
      from=$path"/"$dir"/"$file
      if [ $file = "sshconfig" ]
      then
        to="$HOME/.ssh/"$file
      else
        to="$HOME/."$file
      fi
      ln -f -s $from $to
    done
  done
fi


