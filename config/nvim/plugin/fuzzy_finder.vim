lua require('modille')

" file grep
nnoremap <leader>fg :lua require('telescope.builtin').grep_string({ search = vim.fn.input("🔍 ")})<CR>

" file select
nnoremap <leader>fs :Telescope git_files<CR>

" buffer select
nnoremap <leader>bs :Telescope buffers<CR>

" file old select
nnoremap <leader>fos :Telescope oldfiles<CR>

" file dotfiles select
nnoremap <leader>fds :lua require('modille.fuzzy_finder').file_search_dotfiles()<CR>

" file dotfiles grep
nnoremap <leader>fdg :lua require('modille.fuzzy_finder').file_grep_dotfiles()<CR>
