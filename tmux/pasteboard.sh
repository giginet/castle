cd $HOME
git clone https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard.git
cd tmux-MacOSX-pasteboard
make reattach-to-user-namespace
mkdir $HOME/.bin
cp reattach-to-user-namespace $HOME/.bin/
cd ../
rm -rf tmux-MacOSX-pasteboard
