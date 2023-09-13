local augroup = vim.api.nvim_create_augroup('Modille', {})

-- Custom filetype/syntax
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = augroup,
  pattern = { 'Berksfile', 'Guardfile', 'Vagrantfile' },
  command = 'set syntax=ruby',
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = augroup,
  pattern = '*.pem',
  command = 'set filetype=pem',
})

-- Templates
vim.api.nvim_create_autocmd('BufNewFile', {
  group = augroup,
  pattern = '*.rb',
  command = '0r ~/git/github.com/modille/dotfiles/tag-vim/templates/skeleton.rb',
})
vim.api.nvim_create_autocmd('BufNewFile', {
  group = augroup,
  pattern = '*.sh',
  command = '0r ~/git/github.com/modille/dotfiles/tag-vim/templates/skeleton.sh',
})
vim.api.nvim_create_autocmd('BufNewFile', {
  group = augroup,
  pattern = 'Gemfile',
  command = '0r ~/git/github.com/modille/dotfiles/tag-vim/templates/Gemfile',
})

-- Custom gx
vim.cmd([[
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
]])
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = augroup,
  pattern = 'package.json',
  command = 'nnoremap <buffer> <silent> gx :call PackageJsonGx()<cr>',
})
