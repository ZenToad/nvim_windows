return {
	-- Icons for file explorers and UI
	{
		'nvim-tree/nvim-web-devicons',
		config = function()
		    require('nvim-web-devicons').setup({ default = true })
		end
	},
	-- File Explorer: NERDTree (keeping for compatibility)
	{
		"preservim/nerdtree",
		dependencies = { 
			'nvim-tree/nvim-web-devicons',
			'ryanoasis/vim-devicons' -- NERDTree icon support
		},
		config = function()
			-- NERDTree keybindings (moved from config.lua for better organization)
			vim.keymap.set("n", "<C-k><C-b>", vim.cmd.NERDTreeToggle, { desc = "Toggle NERDTree" })
			vim.keymap.set("i", "<C-k><C-b>", vim.cmd.NERDTreeToggle, { desc = "Toggle NERDTree" })
			
			-- NERDTree settings
			vim.g.NERDTreeShowHidden = 1 -- Show hidden files
			vim.g.NERDTreeIgnore = {'\\.git$', 'node_modules', '\\.DS_Store'} -- Ignore patterns
		end,
	},
}
