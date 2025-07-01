return {
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      default = {
        -- make dir_path relative to current file rather than the cwd
        -- To see your current working directory run `:pwd`
        relative_to_current_file = true, ---@type boolean

        -- I want to save the images in a directory named after the current file,
        -- but I want the name of the dir to end with `-img`
        dir_path = function()
          return vim.fn.expand("%:t:r") .. "-img"
        end,
      },
      filetypes = {
        markdown = {
          -- encode spaces and special characters in file path
          url_encode_path = true, ---@type boolean

          -- -- The template is what specifies how the alternative text and path
          -- -- of the image will appear in your file
          --
          -- -- $CURSOR will paste the image and place your cursor in that part so
          -- -- you can type the "alternative text", keep in mind that this will
          -- -- not affect the name that the image physically has
          -- template = "![$CURSOR]($FILE_PATH)", ---@type string
          --
          -- -- This will just statically type "Image" in the alternative text
          -- template = "![Image]($FILE_PATH)", ---@type string
          --
          -- -- This will dynamically configure the alternative text to show the
          -- -- same that you configured as the "file_name" above
          template = "![$FILE_NAME]($FILE_PATH)", ---@type string
        },
      },
    },
    keys = {
      { "<leader>v", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
}
