let g:startify_change_to_vcs_root = 1
let g:startify_session_dir = '~/.vim/sessions'

" Custom header
function! s:filter_header(lines) abort
  let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
  let centered_lines = map(copy(a:lines),
    \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
  return centered_lines
endfunction
let g:startify_custom_header = s:filter_header([
   \ '        ________ ++     ________',
   \ '       /VVVVVVVV\++++  /VVVVVVVV\',
   \ '       \VVVVVVVV/++++++\VVVVVVVV/',
   \ '        |VVVVVV|++++++++/VVVVV/''',
   \ '        |VVVVVV|++++++/VVVVV/''',
   \ '       +|VVVVVV|++++/VVVVV/''+',
   \ '     +++|VVVVVV|++/VVVVV/''+++++',
   \ '   +++++|VVVVVV|/VVVVV/''+++++++++',
   \ '     +++|VVVVVVVVVVV/''+++++++++',
   \ '       +|VVVVVVVVV/''+++++++++',
   \ '        |VVVVVVV/''+++++++++',
   \ '        |VVVVV/''+++++++++',
   \ '        |VVV/''+++++++++',
   \ '        ''V/''   ++++++',
   \ '                 ++',
   \ ])
