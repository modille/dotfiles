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

  -- When doing a typical git commit:
  -- # On branch yadda-123456789
  local onBranchPattern = "^# On branch .*-#?(%d+)$"

  -- When doing an interactive rebase:
  -- # You are currently rebasing branch 'yadda-123456789' on '76c05108'.
  local rebasingBranchPattern = "^# You are currently rebasing branch '.*-#?(%d+)' on '.*'.$"

  -- Search through each line for the pattern
  for _, line in ipairs(lines) do
    local tracker_id = line:match(onBranchPattern) or line:match(rebasingBranchPattern)
    if tracker_id then
      -- If a match is found, insert the tracker_id at the current cursor position
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      vim.api.nvim_buf_set_text(bufnr, row - 1, col, row - 1, col, { "[#" .. tracker_id .. "]" })
      break
    end
  end
end, { noremap = true })

vim.keymap.set("n", "<leader>sid", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- Patterns to match the branch line in the commit message buffer
  local branch_patterns = {
    "^# On branch (.+)$",
    "^# You are currently rebasing branch '(.+)' on '.*'.$",
    "^# You are currently editing a commit while rebasing branch '(.+)' on '.*'.$",
  }

  -- Patterns to extract the story ID from the branch name
  local shortcut_id_patterns = {
    "sc%-(%d+)", -- e.g., feature/sc-12345/yadda-yadda
    "(%d+)$", -- e.g., yadda-yadda-12345
  }

  local function extract_shortcut_id(branch_name)
    for _, pat in ipairs(shortcut_id_patterns) do
      local id = branch_name:match(pat)
      if id then
        return id
      end
    end
    return nil
  end

  for _, line in ipairs(lines) do
    for _, pat in ipairs(branch_patterns) do
      local branch_name = line:match(pat)
      if branch_name then
        local shortcut_id = extract_shortcut_id(branch_name)
        if shortcut_id then
          local row, col = unpack(vim.api.nvim_win_get_cursor(0))
          vim.api.nvim_buf_set_text(bufnr, row - 1, col, row - 1, col, { "[sc-" .. shortcut_id .. "]" })
          return
        end
      end
    end
  end

  vim.notify("Failed to determine Shortcut story ID", vim.log.levels.WARN)
end, { noremap = true })

-- ############################################################################

-- From https://linkarzu.com/posts/neovim/images-neovim/

-- Open image under cursor in Finder (macOS)
-- If using absolute paths, use the default `gx` to open the image instead
vim.keymap.set("n", "<leader>if", function()
  local function get_image_path()
    -- Get the current line
    local line = vim.api.nvim_get_current_line()
    -- Pattern to match image path in Markdown
    local image_pattern = "%[.-%]%((.-)%)"
    -- Extract relative image path
    local _, _, image_path = string.find(line, image_pattern)

    return image_path
  end

  -- Get the image path
  local image_path = get_image_path()

  if image_path then
    -- Check if the image path starts with "http" or "https"
    if string.sub(image_path, 1, 4) == "http" then
      print("URL image, use 'gx' to open it in the default browser.")
    else
      -- Construct absolute image path
      local current_file_path = vim.fn.expand("%:p:h")
      local absolute_image_path = current_file_path .. "/" .. image_path

      -- Open the containing folder in Finder and select the image file
      local command = "open -R " .. vim.fn.shellescape(absolute_image_path)
      local success = vim.fn.system(command)

      if success == 0 then
        print("Opened image in Finder: " .. absolute_image_path)
      else
        print("Failed to open image in Finder: " .. absolute_image_path)
      end
    end
  else
    print("No image found under the cursor")
  end
end, { desc = "(macOS) Open image under cursor in Finder" })

-- ############################################################################

-- Delete image file under cursor using trash app (macOS)
vim.keymap.set("n", "<leader>id", function()
  local function get_image_path()
    -- Get the current line
    local line = vim.api.nvim_get_current_line()
    -- Pattern to match image path in Markdown
    local image_pattern = "%[.-%]%((.-)%)"
    -- Extract relative image path
    local _, _, image_path = string.find(line, image_pattern)

    return image_path
  end

  -- Get the image path
  local image_path = get_image_path()

  if image_path then
    -- Check if the image path starts with "http" or "https"
    if string.sub(image_path, 1, 4) == "http" then
      vim.api.nvim_echo({
        { "URL image cannot be deleted from disk.", "WarningMsg" },
      }, false, {})
    else
      -- Construct absolute image path
      local current_file_path = vim.fn.expand("%:p:h")
      local absolute_image_path = current_file_path .. "/" .. image_path

      -- Check if trash utility is installed
      if vim.fn.executable("trash") == 0 then
        vim.api.nvim_echo({
          { "- Trash utility not installed. Make sure to install it first\n", "ErrorMsg" },
          { "- In macOS run `brew install trash`\n", nil },
        }, false, {})
        return
      end

      -- Prompt for confirmation before deleting the image
      vim.ui.input({
        prompt = "Delete image file? (y/n) ",
      }, function(input)
        if input == "y" or input == "Y" then
          -- Delete the image file using trash app
          local success, _ = pcall(function()
            vim.fn.system({ "trash", vim.fn.fnameescape(absolute_image_path) })
          end)

          if success then
            vim.api.nvim_echo({
              { "Image file deleted from disk:\n", "Normal" },
              { absolute_image_path, "Normal" },
            }, false, {})
            -- I'll refresh the images, but will clear them first
            -- I'm using [[ ]] to escape the special characters in a command
            vim.cmd([[lua require("image").clear()]])
            -- Reloads the file to reflect the changes
            vim.cmd("edit!")
          else
            vim.api.nvim_echo({
              { "Failed to delete image file:\n", "ErrorMsg" },
              { absolute_image_path, "ErrorMsg" },
            }, false, {})
          end
        else
          vim.api.nvim_echo({
            { "Image deletion canceled.", "Normal" },
          }, false, {})
        end
      end)
    end
  else
    vim.api.nvim_echo({
      { "No image found under the cursor", "WarningMsg" },
    }, false, {})
  end
end, { desc = "(macOS) Delete image file under cursor" })

-- ############################################################################

-- Refresh the images in the current buffer
-- Useful if you delete an actual image file and want to see the changes
-- without having to re-open neovim
vim.keymap.set("n", "<leader>ir", function()
  -- First I clear the images
  -- I'm using [[ ]] to escape the special characters in a command
  vim.cmd([[lua require("image").clear()]])
  -- Reloads the file to reflect the changes
  vim.cmd("edit!")
  print("Images refreshed")
end, { desc = "Refresh images" })

-- ############################################################################

-- Set up a keymap to clear all images in the current buffer
vim.keymap.set("n", "<leader>ic", function()
  -- This is the command that clears the images
  -- I'm using [[ ]] to escape the special characters in a command
  vim.cmd([[lua require("image").clear()]])
  print("Images cleared")
end, { desc = "Clear images" })
