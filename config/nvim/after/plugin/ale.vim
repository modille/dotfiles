" let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_use_global = 0

" Use `bundle exec rubocop`
let g:ale_ruby_rubocop_executable = 'bundle'

let g:ale_linter_aliases = {'javascript.jsx': 'javascript', 'jsx': 'javascript'}

let g:ale_html_tidy_executable = '/usr/local/bin/tidy'

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'markdown': ['prettier'],
\   'ruby': ['rubocop'],
\}

let g:ale_fix_on_save = 1

" Will eventually become the default
" https://www.reddit.com/r/vim/comments/bs95ud/announcement_changing_default_linting_options_for
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

" let g:ale_sign_error = ''
" let g:ale_sign_warning = ''
highlight link ALEErrorSign todo

" Map movement through errors with wrapping around the file.
" nmap <silent> <Leader>ap <Plug>(ale_previous_wrap)
" nmap <silent> <Leader>an <Plug>(ale_next_wrap)
