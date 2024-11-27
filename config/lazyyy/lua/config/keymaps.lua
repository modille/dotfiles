-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Use ; to enter command mode instead of :
vim.keymap.set({ "n", "v" }, ";", ":", { remap = true })

-- Hide other windows (:only, :on)
vim.keymap.set("n", "<Leader>o", "<Cmd>only<CR>")

-- Yank, delete, and paste
vim.keymap.set("v", "<Leader>y", '"+y', { remap = true })
vim.keymap.set("v", "<Leader>d", '"+d', { remap = true })
vim.keymap.set({ "n", "v" }, "<Leader>p", '"+p', { remap = true })
vim.keymap.set({ "n", "v" }, "<Leader>P", '"+P', { remap = true })

-- Re-select blocks after indenting
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv|")
vim.keymap.set("n", ">", ">>_")
vim.keymap.set("n", "<", "<<_")

-- spf13 and SpaceVim-like bindings
vim.keymap.set("n", "<Leader>cc", "<Cmd>cclose<CR>", { silent = true })
vim.keymap.set("n", "<Leader>co", "<Cmd>copen<CR>", { silent = true })
vim.keymap.set("n", "<Leader>lc", "<Cmd>lclose<CR>", { silent = true })
vim.keymap.set("n", "<Leader>lo", "<Cmd>lopen<CR>", { silent = true })
vim.keymap.set("n", "<Leader>q", "<Cmd>q<CR>", { silent = true })
vim.keymap.set("n", "<Leader>w", "<Cmd>w<CR>", { silent = true })

-- Disable Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- https://vim.fandom.com/wiki/Selecting_your_pasted_text
-- After pasting, type gp to select the pasted text in visual mode.
-- This is similar to the standard gv which you can type to select the last visually-selected text.
vim.cmd([[ nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]' ]])

-- Paragraph motions don't change the jumplist
vim.keymap.set("n", "}", "<Cmd>keepjumps normal! }<CR>", { silent = true })
vim.keymap.set("n", "{", "<Cmd>keepjumps normal! {<CR>", { silent = true })

-- https://www.reddit.com/r/vim/comments/uorjet/comment/i8ie8om/
-- 0 once = to the first character of the line
-- 0 twice = to the first non-blank character of the line
vim.cmd([[ nnoremap <expr> 0 (col('.') == 1) ? '^' : '0' ]])

-- Overwrite LazyVim defaults
vim.keymap.set("n", "[e", "<Plug>(unimpaired-move-up)")
vim.keymap.set("n", "]e", "<Plug>(unimpaired-move-down)")
vim.keymap.set("x", "[e", "<Plug>(unimpaired-move-selection-up)")
vim.keymap.set("x", "]e", "<Plug>(unimpaired-move-selection-down)")

vim.keymap.set("n", "<leader>tid", function()
  -- Get the current buffer and all lines in the buffer
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- Define the pattern to match
  local pattern = "^# On branch.*-#?(%d+)$"

  -- Search through each line for the pattern
  for _, line in ipairs(lines) do
    local tracker_id = line:match(pattern)
    if tracker_id then
      -- If a match is found, insert the tracker_id at the current cursor position
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      vim.api.nvim_buf_set_text(bufnr, row - 1, col, row - 1, col, { "[#" .. tracker_id .. "]" })
      break
    end
  end
end, { noremap = true })
