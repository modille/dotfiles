--- @type LazySpec
return {
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup({
        ---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
        use_default_keymaps = false,
      })
    end,
    keys = {
      {
        "<space>bt",
        function()
          require("treesj").toggle()
        end,
        desc = "Toggle treesj",
      },
      -- { "<space>j", function() require("treesj").join() end, desc = "Join treesj" },
      -- { "<space>s", function() require("treesj").split() end, desc = "Split treesj" },
    },
  },
}
