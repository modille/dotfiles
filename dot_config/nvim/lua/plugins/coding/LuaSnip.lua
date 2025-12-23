---@type LazySpec
return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      -- load snippets from
      -- ~/.config/nvim/luasnippets
      require("luasnip.loaders.from_lua").load()
    end,
  },
}
