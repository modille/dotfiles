-- local M = {}

-- function M.setup()
--   local wk = require('which-key')

--   local conf = {}

--   local opts = {
--     mode = 'n', -- Normal mode
--     prefix = '<leader>',
--     buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--     silent = true, -- use `silent` when creating keymaps
--     noremap = true, -- use `noremap` when creating keymaps
--     nowait = false, -- use `nowait` when creating keymaps
--   }

--   local mappings = {
--     ['w'] = { '<cmd>w<CR>', 'Write' },
--     ['q'] = { '<cmd>q<CR>', 'Quit' },

--     g = {
--       name = 'Git',
--       s = { '<cmd>Git<CR>', 'Status' },
--       b = { '<cmd>Git blame<CR>', 'Blame' },
--       l = { '<cmd>Gclog<CR>', 'Log' },
--     },
--   }

--   wk.setup(conf)
--   wk.register(mappings, opts)
-- end

-- return M
