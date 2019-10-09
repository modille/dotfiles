if has('autocmd')
  augroup modilleAutocmds
    autocmd!

    " Close the preview window after completion is done
    autocmd CompleteDone * pclose!

    " Custom filetype/syntax
    autocmd BufNewFile,BufRead Berksfile,Guardfile,Vagrantfile set syntax=ruby

    " SpaceHi
    autocmd syntax * SpaceHi
    autocmd FileType Mundo,MundoDiff,go,help,startify,vim NoSpaceHi
    autocmd Syntax diff NoSpaceHi

    " Templates
    autocmd BufNewFile *.sh 0r ~/git/github.com/modille/dotfiles/tag-vim/templates/skeleton.sh
    autocmd BufNewFile Gemfile 0r ~/git/github.com/modille/dotfiles/tag-vim/templates/Gemfile
  augroup END
endif
