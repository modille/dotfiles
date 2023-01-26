" https://doriankarter.com/customize-vims-gx-mapping/
function! PackageJsonGx() abort
  let l:line = getline('.')
  let l:package = matchlist(l:line, '\v"(.*)": "(.*)"')

  if len(l:package) > 0
    let l:package_name = l:package[1]
    let l:url = 'https://www.npmjs.com/package/' . l:package_name
    call netrw#BrowseX(l:url, 0)
  endif
endfunction

augroup modilleAutocmds
  autocmd!

  " Custom filetype/syntax
  autocmd BufNewFile,BufRead Berksfile,Guardfile,Vagrantfile set syntax=ruby

  " Custom options
  autocmd FileType lua set colorcolumn=120

  " https://github.com/jpalardy/spacehi.vim
  " autocmd FileType Mundo,MundoDiff,alpha,go,help,startify,vim NoSpaceHi
  " autocmd Syntax * SpaceHi
  " autocmd Syntax diff NoSpaceHi
  " autocmd User TelescopeFindPre NoSpaceHi
  " autocmd User TelescopePreviewerLoaded NoSpaceHi

  " Templates
  autocmd BufNewFile *.rb 0r ~/git/github.com/modille/dotfiles/tag-vim/templates/skeleton.rb
  autocmd BufNewFile *.sh 0r ~/git/github.com/modille/dotfiles/tag-vim/templates/skeleton.sh
  autocmd BufNewFile Gemfile 0r ~/git/github.com/modille/dotfiles/tag-vim/templates/Gemfile

  autocmd BufRead,BufNewFile package.json nnoremap <buffer> <silent> gx :call PackageJsonGx()<cr>
augroup END
