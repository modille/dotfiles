return {
  {
    "folke/noice.nvim",
    enabled = false,     -- snacks.lua will handle this
    opts = {
      messages = {
        view = "mini",               -- default "notify"
        view_error = "notify",       -- default "notify"
        view_warn = "mini",          -- default "notify"
        view_history = "messages",   -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      },
    },
  },
}
