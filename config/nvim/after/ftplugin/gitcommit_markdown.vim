setlocal comments=:# commentstring=#\ %s
setlocal nomodeline tabstop=8 formatoptions+=tl textwidth=72
setlocal formatoptions-=c formatoptions-=r formatoptions-=o formatoptions-=q
setlocal spell

if exists('+colorcolumn')
  set colorcolumn=72
endif
