---@type LazySpec
return {
  {
    "GCBallesteros/jupytext.nvim",
    config = true,
    lazy = false,
    opts = {
      custom_language_formatting = {
        python = {
          -- quarto instead of markdown so we can run_cell
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto", -- you can set whatever filetype you want here
        },
      },
    },
  },
}
