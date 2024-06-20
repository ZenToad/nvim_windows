return {
	-- Icons: Nvim-Web-Devicons
	{
		'nvim-tree/nvim-web-devicons',
		config = function()
		    require'nvim-web-devicons'.setup { default = true; }
		end
	},
	-- vim-devicons for NERDTree icons
	{
		'ryanoasis/vim-devicons',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
		    require'nvim-web-devicons'.setup { default = true; }
		end
	},
	{
	-- File Explorer: NERDTree
		"preservim/nerdtree",
		config = function()
			vim.keymap.set("n", "<C-k><C-b>", vim.cmd.NERDTreeToggle)
			vim.keymap.set("i", "<C-k><C-b>", vim.cmd.NERDTreeToggle)
		end,
	},
}
