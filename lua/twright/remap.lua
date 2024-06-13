-- key bindings and stuff

vim.g.mapleader = ","

-- " REQUIRED
vim.keymap.set("n", ";", ":", {noremap = true})
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', 'q;', 'q:', {noremap = true})
vim.keymap.set('n', '<SPACE>', 'o<ESC>', {silent = true, noremap = true})

-- Tagbar
vim.keymap.set('n', '<F9>', ':TagbarOpen fj<CR>', {silent = true})

-- Toggle word wrap
vim.keymap.set('n', '<leader>w', ':set nowrap!<CR>', {silent = true, noremap = true})

-- NERDTree
vim.keymap.set("n", "<C-k><C-b>", vim.cmd.NERDTreeToggle)
vim.keymap.set("i", "<C-k><C-b>", vim.cmd.NERDTreeToggle)

vim.keymap.set('n', '<leader>/', vim.cmd.nohl)
vim.keymap.set('n', '<leader>vs', vim.cmd.vs)

-- Turn search highlight off
vim.keymap.set('n', '<leader>/', vim.cmd.nohl, {noremap = true})

-- Move around windows
vim.keymap.set('n', '<C-H>', '<C-W>h', {noremap = true})
vim.keymap.set('n', '<C-J>', '<C-W>jkk', {noremap = true})
vim.keymap.set('n', '<C-K>', '<C-W>k', {noremap = true})
vim.keymap.set('n', '<C-L>', '<C-W>l', {noremap = true})

-- Open new tab
vim.keymap.set('n', '<C-T>', vim.cmd.tabnew, {silent = true, noremap = true})

-- Open new scratch buffer
-- nnoremap <C-N> :vnew <CR>
vim.keymap.set('n', '<C-N>', vim.cmd.vnew, {noremap = true})

-- Move lines up/down with Alt jk
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', {silent = true, noremap = true})
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', {silent = true, noremap = true})
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', {silent = true, noremap = true})
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', {silent = true, noremap = true})
vim.keymap.set('v', '<A-k>', ':m <-2<CR>gv=gv', {silent = true, noremap = true})
vim.keymap.set('v', '<A-j>', ':m >+1<CR>gv=gv', {silent = true, noremap = true})

-- Fancy cursor movement
vim.keymap.set('n', '<leader>zt', 'zt8k8j', {silent = true, noremap = true})
vim.keymap.set('n', '<leader>zb', 'zb8j8k', {silent = true, noremap = true})

-- vertical split same file
vim.keymap.set('n', '<leader>vs', vim.cmd.vsplit, {noremap = true})

-- Don't use Ex mode, use Q for formatting
vim.keymap.set('', 'Q', 'gq')

-- Remap VIM 0 to first non-blank character
vim.keymap.set('', '0', '^')

vim.api.nvim_command([[autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>]])

-- exit terminal mode
vim.keymap.set('t', 'ESC', '<C-\\><C-n>')

-- open vimrc director
vim.keymap.set('n', '<leader>ev', ':tabnew<CR>:cd ~/AppData/Local/nvim<CR>:NERDTreeToggle<CR>')

vim.keymap.set('n', '<leader>m', ':ToggleTerm("build.bat")<CR>', {silent = false, noremap = true})
