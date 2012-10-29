# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"

#install pythonbrew and setup python
curl -kL https://raw.github.com/saghul/pythonz/master/pythonz-install | bash
pythonz install 2.7.3
pythonz switch 2.7.3

#install pythonpackages
pip install pysmell
pip install ropevim
pip install ipython

# install python support vim
brew install mercurial
brew install https://raw.github.com/Homebrew/homebrew-dupes/master/vim.rb

brew install zsh

# for vim plugins
brew install node
brew install yuicompressor

# for development
brew install tmux
brew install reattach-to-user-namespace
brew install autojump

# for git
brew install tig
brew install hub
brew install git-flow
