# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"

#install pythonbrew and setup python
curl -kL http://xrl.us/pythonbrewinstall | bash
pythonbrew install 2.7.2
pythonbrew switch 2.7.2

#install pythonpackages
pip install mercurial
pip install pysmell
pip install pyflakes
pip install ropevim
pip install ipython

# install python support vim
brew install https://raw.github.com/adamv/homebrew-alt/master/duplicates/vim.rb

# for vim plugins
brew install node
brew install yuicompressor

