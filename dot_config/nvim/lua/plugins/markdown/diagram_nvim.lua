--- @type LazySpec
return {
  {
    "3rd/diagram.nvim",
    dependencies = {
      "3rd/image.nvim",
    },
    opts = {
      -- Disable automatic rendering for manual-only workflow
      events = {
        render_buffer = {}, -- Empty = no automatic rendering
        clear_buffer = { "BufLeave" },
      },
      renderer_options = {
        mermaid = {
          theme = "dark",
          scale = 2,
        },
      },
    },
    keys = {
      {
        "<leader>rd", -- "render diagram"
        function()
          require("diagram").show_diagram_hover()
        end,
        mode = "n",
        ft = { "markdown", "norg" }, -- Only in these filetypes
        desc = "Show diagram in new tab",
      },
    },
  },
}
