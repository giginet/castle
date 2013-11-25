" Ruby
au BufNewFile,BufRead *.rb,*.rbw,*.gem,*.gemspec set filetype=ruby

" Ruby on Rails
au BufNewFile,BufRead *.builder,*.rxml,*.rjs set filetype=ruby

" Rakefile
au BufNewFile,BufRead [rR]akefile,*.rake set filetype=ruby

" eRuby
au BufNewFile,BufRead *.erb,*.rhtml set filetype=eruby
autocmd BufNewFile *.rb 0r ~/.vim/templates/ruby.rb

" jBuilder
au BufNewFile,BufRead *.jbuilder set filetype=ruby

" Podfile
au BufNewFile,BufRead Podfile,*.podspec set filetype=ruby

" Gemfile
au BufNewFile,BufRead Gemfile set filetype=ruby

" Guardfile
au BufNewFile,BufRead Guardfile set filetype=ruby
