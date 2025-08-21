return {
	-- Icons for file explorers and UI
	{
		'nvim-tree/nvim-web-devicons',
		config = function()
		    require('nvim-web-devicons').setup({ default = true })
		end
	},
	-- File Explorer: nvim-tree
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			-- Disable netrw (required for nvim-tree)
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			
			require('nvim-tree').setup({
				view = {
					width = 30,
				},
				renderer = {
					group_empty = true,
					icons = {
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
						},
					},
				},
				filters = {
					dotfiles = false, -- Show hidden files
					custom = { '.git', 'node_modules', '.DS_Store' }, -- Ignore patterns
				},
				git = {
					enable = true,
					ignore = false,
				},
			})
			
			-- nvim-tree keybindings
			vim.keymap.set("n", "<C-k><C-b>", vim.cmd.NvimTreeToggle, { desc = "Toggle nvim-tree" })
			vim.keymap.set("i", "<C-k><C-b>", vim.cmd.NvimTreeToggle, { desc = "Toggle nvim-tree" })
		end,
	},
}
