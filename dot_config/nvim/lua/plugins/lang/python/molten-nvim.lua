---@type LazySpec
return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    keys = {
      { "<leader>mi", ":MoltenInit<cr>", desc = "[m]olten [i]nit" },
    },
    init = function()
      vim.g.molten_output_win_max_height = 25

      vim.api.nvim_create_autocmd("User", {
        pattern = "MoltenInitPost",
        callback = function()
          -- quarto runner keymaps
          -- use localleader \
          local quarto_runner = require("quarto.runner")
          vim.keymap.set("n", "<localleader>rc", quarto_runner.run_cell, { desc = "run cell", silent = true })
          vim.keymap.set(
            "n",
            "<localleader>rk",
            quarto_runner.run_above,
            { desc = "run cell and above", silent = true }
          )
          vim.keymap.set(
            "n",
            "<localleader>rj",
            quarto_runner.run_below,
            { desc = "run cell and below", silent = true }
          )
          vim.keymap.set("n", "<localleader>rl", quarto_runner.run_line, { desc = "run line", silent = true })
          vim.keymap.set("n", "<localleader>rf", quarto_runner.run_all, { desc = "run all cells", silent = true })

          -- molten keymaps
          -- use localleader \
          vim.keymap.set(
            "n",
            "<localleader>o",
            ":noautocmd MoltenEnterOutput<CR>",
            { desc = "open output window", silent = true }
          )
        end,
      })
    end,
  },
}
