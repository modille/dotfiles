---@type LazySpec
return {
  {
    "vimwiki/vimwiki",
    enabled = false,
    init = function()
      vim.cmd(
        [[ let g:vimwiki_list = [{ 'path': '~/Library/CloudStorage/Dropbox/vimwiki/', 'syntax': 'markdown', 'ext': 'md', 'auto_diary_index': 1 }] ]]
      )
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_hl_cb_checked = 1
      vim.g.vimwiki_auto_header = 1
      vim.g.vimwiki_key_mappings = {
        -- header mapping (-) conflicts with tpope/vim-vinegar
        headers = 0,
      }
      -- remove tab-related mappings
      vim.cmd([[ nmap <Nop> <Plug>VimwikiTabIndex ]])
      vim.cmd([[ nmap <Nop> <Plug>VimwikiTabMakeDiaryNote ]])
    end,
  },
}
