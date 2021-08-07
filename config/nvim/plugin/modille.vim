" Lots of alternatives methods at
" http://vim.wikia.com/wiki/Open_a_web-browser_with_the_URL_in_the_current_line
" gx is similar
function! SearchVisualDockerHubOpen()
  " Get search string from visual selection
  let l:tmp = @"
  execute 'normal! vgvy'
  let l:result = @"
  let @" = l:tmp

  " 1. split the search string in seperate words
  " 2. join the words seperated by +
  " 3. replace all " with an empty string
  let l:term = substitute(join(split(l:result),'+'),'"','','g')

  let l:dockerhub = 'https://hub.docker.com/search/?isAutomated=0&isOfficial=0&page=1&pullCount=0&starCount=0&q='
  let l:query = l:dockerhub . l:term

  let l:browser_cmd = 'open'

  execute 'silent !' . l:browser_cmd . ' "' . l:query . '"'
endfunction

function! SearchVisualNpmJsOpen()
  " Get search string from visual selection
  let l:tmp = @"
  execute 'normal! vgvy'
  let l:result = @"
  let @" = l:tmp

  " 1. split the search string in seperate words (by space, @, /)
  " 2. join the words seperated by +
  " 3. replace all " with an empty string
  let l:term = substitute(join(split(l:result,'[ @/]'),'+'),'"','','g')

  let l:npmjs = 'https://www.npmjs.com/search?q='
  let l:query = l:npmjs . l:term

  let l:browser_cmd = 'open'

  execute 'silent !' . l:browser_cmd . ' "' . l:query . '"'
endfunction
