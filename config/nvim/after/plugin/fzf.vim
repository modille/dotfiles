command! -bar -bang -nargs=? -complete=buffer Buffers
  \ call fzf#vim#buffers(<q-args>, <bang>0)
command! -bang -nargs=* History
  \ call fzf#vim#history(<bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --hidden '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
command! -bang -nargs=* Rgi
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --hidden -i '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

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
