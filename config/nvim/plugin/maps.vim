" Use ; to enter command mode instead of :
nmap ; :
vmap ; :

" Hide other windows (:only, :on)
map <Leader>o :only<CR>

" Yank, delete, and paste
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Re-select blocks after indenting
xnoremap < <gv
xnoremap > >gv|
nnoremap > >>_
nnoremap < <<_

" WIP: Folding
" close all open folds apart from the one that the cursor is on
nnoremap <Leader>zz zMzv
" Better folding mnemonics: [o]pen, [c]lose, etc.
" open all folds
nnoremap <Leader>zo zR
" close all folds
nnoremap <Leader>zc zM
" move down to top of next fold
nnoremap <Leader>z<Down> zj
" move up to bottom of previous fold
nnoremap <Leader>z<Up> zk

" spf13 and SpaceVim-like bindings
nnoremap <silent> <Leader>cc :cclose<CR>
nnoremap <silent> <Leader>co :copen<CR>
nnoremap <silent> <Leader>lc :lclose<CR>
nnoremap <silent> <Leader>lo :lopen<CR>
nnoremap <silent> <Leader>q :q<CR>
nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>fed :e $MYVIMRC<CR>
nnoremap <silent> <Leader>feR :source $MYVIMRC<CR>

" Disable Ex mode
nnoremap Q <nop>

" Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

if has('nvim')
  " Easier escape in terminal
  tnoremap <Esc> <C-\><C-n>

  " ...but still be able to send an Escape key
  " Mnemonic: Verbatim escape (similar to :help i_ctrl-v)
  tnoremap <C-v><Esc> <Esc>
endif

nnoremap tc :tabclose<CR>
nnoremap tn :tabnext<CR>
nnoremap tp :tabprev<CR>

" https://vim.fandom.com/wiki/Selecting_your_pasted_text
" After pasting, type gp to select the pasted text in visual mode.
" This is similar to the standard gv which you can type to select the last visually-selected text.
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Paragraph motions don't change the jumplist
nnoremap <silent> } :keepjumps normal! }<cr>
nnoremap <silent> { :keepjumps normal! {<cr>

" https://www.reddit.com/r/vim/comments/uorjet/comment/i8ie8om/
" 0 once = to the first character of the line
" 0 twice = to the first non-blank character of the line
nnoremap <expr> 0 (col('.') == 1) ? '^' : '0'
