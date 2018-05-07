" let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1

" nmap <Leader>s <Plug>(easymotion-overwin-f)
" nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Line mappings
" omap <Leader>L  <Plug>(easyoperator-line-select)
" xmap <Leader>L  <Plug>(easyoperator-line-select)
" nmap d<Leader>L <Plug>(easyoperator-line-delete)
" nmap p<Leader>L <Plug>(easyoperator-line-yank)

" Phrase mappings
" omap <Leader>p  <Plug>(easyoperator-phrase-select)
" xmap <Leader>p  <Plug>(easyoperator-phrase-select)
" nmap d<Leader>p <Plug>(easyoperator-phrase-delete)
" nmap p<Leader>p <Plug>(easyoperator-phrase-yank)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
