" let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_use_global = 0

let g:ale_linter_aliases = {'javascript.jsx': 'javascript', 'jsx': 'javascript'}

" Disable ale for java in order to use Eclim instead
let g:ale_linters = {
\   'java': [],
\   'javascript': ['eslint', 'flow']
\}

let g:ale_html_tidy_executable = '/usr/local/bin/tidy'

let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

let g:ale_fix_on_save = 1

let g:ale_sign_error = ''
let g:ale_sign_warning = ''
highlight link ALEErrorSign todo

" Map movement through errors without wrapping.
nmap <silent> <Leader>ap <Plug>(ale_previous)
nmap <silent> <Leader>an <Plug>(ale_next)
