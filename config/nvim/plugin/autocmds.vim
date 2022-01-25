augroup modilleAutocmds
  autocmd!

  " Custom filetype/syntax
  autocmd BufNewFile,BufRead Berksfile,Guardfile,Vagrantfile set syntax=ruby

  " Custom options
  autocmd FileType lua set colorcolumn=120

  " https://github.com/jpalardy/spacehi.vim
  autocmd FileType Mundo,MundoDiff,go,help,startify,vim NoSpaceHi
  autocmd Syntax * SpaceHi
  autocmd Syntax diff NoSpaceHi

  " Templates
  autocmd BufNewFile *.rb 0r ~/git/github.com/modille/dotfiles/tag-vim/templates/skeleton.rb
  autocmd BufNewFile *.sh 0r ~/git/github.com/modille/dotfiles/tag-vim/templates/skeleton.sh
  autocmd BufNewFile Gemfile 0r ~/git/github.com/modille/dotfiles/tag-vim/templates/Gemfile
augroup END
