" The default of 31 is just a little too narrow.
let g:NERDTreeWinSize=40

" Disable display of '?' text and 'Bookmarks' label.
let g:NERDTreeMinimalUI=1

" Keep alts and jumps 
let g:NERDTreeCreatePrefix="silent keepalt keepjumps"

let g:NERDTreeGitStatusNodeColorization = 1
let g:NERDTreeGitStatusWithFlags = 1

nmap <silent> <Leader>nt :NERDTreeToggle<CR>
nmap <silent> <Leader>nc :NERDTreeCWD<CR>
nmap <silent> <Leader>nf :NERDTreeFind<CR>
