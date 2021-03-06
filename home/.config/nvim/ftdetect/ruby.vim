" Ruby
au BufNewFile,BufRead *.rb,*.rbw,*.gem,*.gemspec set filetype=ruby

" Ruby on Rails
au BufNewFile,BufRead *.builder,*.rxml,*.rjs set filetype=ruby

" Rakefile
au BufNewFile,BufRead [rR]akefile,*.rake set filetype=ruby

" eRuby
au BufNewFile,BufRead *.erb,*.rhtml set filetype=eruby

" jBuilder
au BufNewFile,BufRead *.jbuilder set filetype=ruby

" Podfile
au BufNewFile,BufRead Podfile,*.podspec set filetype=ruby

" Gemfile
au BufNewFile,BufRead Gemfile set filetype=ruby

" Guardfile
au BufNewFile,BufRead Guardfile set filetype=ruby

" fastlane
au BufNewFile,BufRead Fastfile,Appfile,Snapfile,Scanfile,Gymfile,Matchfile,Deliverfile,Pluginfile set filetype=ruby

" Danger
au BufNewFile,BufRead Dangerfile set filetype=ruby

"miam
au BufNewFile,BufRead *.iam set filetype=ruby
