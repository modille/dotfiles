---@type LazySpec
return {
  {
    "zhisme/copy_with_context.nvim",
    config = function()
      require("copy_with_context").setup({
        mappings = {
          relative = "<leader>cy",
          absolute = "<leader>cY",
          remote = "<leader>ce",
        },
        formats = {
          default = "# {filepath}:{line}", -- Used by relative and absolute mappings
          remote = "# {remote_url}",
        },
        trim_lines = false,
      })
    end,
  },
}
