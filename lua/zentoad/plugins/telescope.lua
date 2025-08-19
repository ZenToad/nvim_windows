return {
    -- Modern Telescope setup (2025 best practices)
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8', -- Use specific stable version
        dependencies = { 
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            local telescope = require('telescope')
            
            -- Enhanced configuration with 2025 optimizations
            telescope.setup({
                defaults = {
                    -- Improved vimgrep_arguments for better search
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case',
                        '--hidden', -- Search hidden files
                        '--glob', '!**/.git/*', -- Exclude .git
                        '--glob', '!**/node_modules/*', -- Exclude node_modules
                    },
                    prompt_prefix = "🔍 ",
                    selection_caret = "❯ ",
                    path_display = { "truncate" },
                    file_ignore_patterns = { "%.git/", "node_modules/" },
                    layout_config = {
                        horizontal = { preview_width = 0.6 },
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({})
                    }
                }
            })
            
            -- Load extensions
            telescope.load_extension('ui-select')
            
            -- Modern 2025 keybindings
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.git_files, { desc = "Find git files" })
            vim.keymap.set('n', '<leader>fa', builtin.find_files, { desc = "Find all files" })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffers" })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })
            
            -- Keep original keybindings for compatibility
            vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Find files" })
            vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Git files" })
            vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = "Live grep" })
            vim.keymap.set('n', '<F12>', builtin.lsp_definitions, { desc = "LSP definitions" })
            vim.keymap.set('n', '<F11>', builtin.lsp_implementations, { desc = "LSP implementations" })
        end
    },
    -- UI Select extension
    {
        'nvim-telescope/telescope-ui-select.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
    },
}
