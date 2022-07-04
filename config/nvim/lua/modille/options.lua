-- The following sections are organized similar to :options

-- 2 moving around, searching and patterns
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- 4 displaying text
vim.opt.number = true
vim.opt.list = true
vim.opt.listchars = 'nbsp:○,tab:▷ ,trail:␣'

-- 5 syntax, highlighting and spelling
vim.opt.hlsearch = true
vim.opt.inccommand = 'split' -- or 'nosplit'
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.colorcolumn = '80'
vim.opt.spell = false -- TODO removeme

-- 6 multiple windows
vim.opt.previewheight = 28
vim.opt.splitbelow = true
vim.opt.splitright = true

-- 13 editing text
-- Enable persistent undo so that undo history persists across vim sessions
vim.opt.undofile = true
vim.opt.undodir = os.getenv('HOME') .. '/.local/share/nvim/undo'
vim.opt.dictionary = '/usr/share/dict/words'

-- 14 tabs and indenting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- 18 reading and writing files
vim.opt.writebackup = false
vim.opt.backup = false
vim.opt.autoread = true

-- 19 the swap file
vim.opt.swapfile = false
vim.opt.updatetime = 100
