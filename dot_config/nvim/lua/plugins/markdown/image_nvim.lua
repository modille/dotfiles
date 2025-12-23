---@type LazySpec
return {
  {
    "3rd/image.nvim",
    dependencies = { "vhyrro/luarocks.nvim" },
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    config = function()
      require("image").setup({
        backend = "kitty",
        kitty_method = "normal",
        processor = "magick_cli",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            only_render_image_at_cursor_mode = "popup",
            floating_windows = true, -- if true, images will be rendered in floating markdown windows
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
          },
          -- Detect and render images referenced in HTML files
          -- Make sure you have an html treesitter parser installed
          html = {
            enabled = true,
          },
          -- Detect and render images referenced in CSS files
          -- Make sure you have a css treesitter parser installed
          css = {
            enabled = true,
          },
        },

        -- auto show/hide images when the editor gains/loses focus
        editor_only_render_when_focused = true,
      })
    end,
  },
}
