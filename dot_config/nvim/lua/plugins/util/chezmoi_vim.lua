--- @type LazySpec
return {
  {
    "alker0/chezmoi.vim", -- set ft for chezmoi-managed files
    lazy = false,
    init = function()
      -- This option is required.
      vim.g["chezmoi#use_tmp_buffer"] = true
      -- add other options here if needed.
    end,
  },
}
