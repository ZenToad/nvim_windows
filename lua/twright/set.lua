-- Cursor settings
vim.opt.guicursor = ""

-- Disable netrw (default file explorer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Line numbers
vim.opt.nu = true
-- vim.opt.relativenumber = true  -- Uncomment this if you want relative line numbers

-- Tabs and indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- No line wrapping
vim.opt.wrap = false

-- Swap and backup files
vim.opt.swapfile = false
vim.opt.backup = false

-- Undo settings
-- Ensure the undodir exists
local undodir = vim.env.HOME .. "/.vim/undodir"
if not vim.loop.fs_stat(undodir) then
    vim.loop.fs_mkdir(undodir, 511) -- 511 decimal is 0777 in octal
end
vim.opt.undodir = undodir
vim.opt.undofile = true

-- Search settings
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Colors
vim.opt.termguicolors = true

-- Scrolling and sign column
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

-- Update time
vim.opt.updatetime = 50

-- File name settings
vim.opt.isfname:append("@-@")
