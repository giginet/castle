path=$(cd $(dirname $0); pwd)
ln -s -f ${path}/.git ~/.git
ln -s -f ${path}/.gitignore ~/.gitignore
ln -s -f ${path}/.gitmodules ~/.gitmodules
ln -s -f ${path}/.tmux.conf ~/.tmum.conf
ln -s -f ${path}/.vim ~/.vim
ln -s -f ${path}/.vim-vundle ~/.vim-vundle
ln -s -f "${path}/.vimrc" ~/.vimrc
ln -s -f ${path}/.zshrc ~/.zshrc
ln -s -f ${path}/gitignore_global ~/.gitignore
ln -s -f ${path}/.gitconfig ~/.gitconfig
ln -s -f ${path}/.hgrc ~/.hgrc
