
-- Set leader key
vim.g.mapleader = ","

-- Key bindings
vim.keymap.set("n", ";", ":", { noremap = true })
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "q;", "q:", { noremap = true })
vim.keymap.set("n", "<SPACE>", "o<ESC>", { silent = true, noremap = true })

-- Tagbar
vim.keymap.set("n", "<F9>", ":TagbarOpen fj<CR>", { silent = true })

-- Toggle word wrap
vim.keymap.set("n", "<leader>w", ":set nowrap!<CR>", { silent = true, noremap = true })

-- NERDTree
vim.keymap.set("n", "<C-k><C-b>", vim.cmd.NERDTreeToggle)
vim.keymap.set("i", "<C-k><C-b>", vim.cmd.NERDTreeToggle)

-- Turn search highlight off
vim.keymap.set("n", "<leader>/", vim.cmd.nohl, { noremap = true })

-- Move around windows
vim.keymap.set("n", "<C-H>", "<C-W>h", { noremap = true })
vim.keymap.set("n", "<C-J>", "<C-W>j", { noremap = true })
vim.keymap.set("n", "<C-K>", "<C-W>k", { noremap = true })
vim.keymap.set("n", "<C-L>", "<C-W>l", { noremap = true })

-- Open new tab
vim.keymap.set("n", "<C-T>", vim.cmd.tabnew, { silent = true, noremap = true })

-- Open new scratch buffer
vim.keymap.set("n", "<C-N>", vim.cmd.vnew, { noremap = true })

-- Move lines up/down with Alt + j/k
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true, noremap = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true, noremap = true })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true, noremap = true })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true, noremap = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, noremap = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, noremap = true })

-- Fancy cursor movement
vim.keymap.set("n", "<leader>zt", "zt8k8j", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>zb", "zb8j8k", { silent = true, noremap = true })

-- Vertical split same file
vim.keymap.set("n", "<leader>vs", vim.cmd.vsplit, { noremap = true })

-- Don't use Ex mode, use Q for formatting
vim.keymap.set("", "Q", "gq")

-- Remap VIM 0 to first non-blank character
vim.keymap.set("", "0", "^")

-- Exit terminal mode
vim.keymap.set("t", "ESC", "<C-\\><C-n>")

-- Open vimrc directory
vim.keymap.set("n", "<leader>ev", ":tabnew<CR>:tcd ~/AppData/Local/nvim<CR>:NERDTreeToggle<CR>")

-- Build command
vim.keymap.set("n", "<leader>m", ':TermExec cmd="build\\build.bat sandbox" go_back=0 direction="float"<CR>', { silent = false, noremap = true })

-- Autocmd for quickfix buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "quickfix",
    callback = function()
        vim.keymap.set("n", "<CR>", "<CR>", { buffer = true, noremap = true })
    end,
})


