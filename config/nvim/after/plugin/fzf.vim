command! -bar -bang -nargs=? -complete=buffer Buffers
  \ call fzf#vim#buffers(<q-args>, <bang>0)

command! -bang -nargs=* History
  \ call fzf#vim#history(<bang>0)

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --hidden '.shellescape(<q-args>), 1,
"   \   <bang>0 ? fzf#vim#with_preview('up:60%')
"   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \   <bang>0)

" command! -bang -nargs=* Rgi
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --hidden -i '.shellescape(<q-args>), 1,
"   \   <bang>0 ? fzf#vim#with_preview('up:60%')
"   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \   <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--no-sort'}), <bang>0)

" sort
command! -bang -nargs=* Rgs
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" function! RipgrepFzf(query, fullscreen)
"   let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
"   let initial_command = printf(command_fmt, shellescape(a:query))
"   let reload_command = printf(command_fmt, '{q}')
"   let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
"   call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
" endfunction

" command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

let g:fzf_action = {
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up.
let g:fzf_history_dir = '~/.fzf-history'

" mnemonic 'Buffer Search'
nnoremap <silent> <Leader>bs :Buffers<CR>
" mnemonic 'File Grep'
nnoremap <silent> <Leader>fg :Rg<space>
" mnemonic 'File History'
nnoremap <silent> <Leader>fh :History<CR>
" mnemonic 'File Search'
nnoremap <silent> <Leader>fs :GFiles<CR>

" Grep the word under cursor
nnoremap <silent> <Leader>gw :silent execute "Rg " . expand("<cword>")<cr>
