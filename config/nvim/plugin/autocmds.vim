if has('autocmd')
  augroup modilleAutocmds
    autocmd!

    " Close the preview window after completion is done
    autocmd CompleteDone * pclose!

    " Custom filetype/syntax
    autocmd BufNewFile,BufRead Berksfile,Guardfile,Vagrantfile set syntax=ruby

    " Seeing-is-believing
    autocmd FileType ruby nmap <buffer> <Enter> <Plug>(seeing-is-believing-mark-and-run)
    autocmd FileType ruby xmap <buffer> <Enter> <Plug>(seeing-is-believing-mark-and-run)
    autocmd FileType ruby nmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
    autocmd FileType ruby xmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
    autocmd FileType ruby imap <buffer> <F4> <Plug>(seeing-is-believing-mark)
    autocmd FileType ruby nmap <buffer> <F5> <Plug>(seeing-is-believing-run)
    autocmd FileType ruby imap <buffer> <F5> <Plug>(seeing-is-believing-run)

    " SpaceHi
    autocmd syntax * SpaceHi
    autocmd FileType Mundo,MundoDiff,go,help,nerdtree,startify,vim NoSpaceHi
    autocmd Syntax diff NoSpaceHi

    " Templates
    autocmd BufNewFile *.sh 0r ~/git/github.com/modille/dotfiles/tag-vim/templates/skeleton.sh
    autocmd BufNewFile Gemfile 0r ~/git/github.com/modille/dotfiles/tag-vim/templates/Gemfile
  augroup END
endif
