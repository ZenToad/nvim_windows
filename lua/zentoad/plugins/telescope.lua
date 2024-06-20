return {
    -- Search Tool: Ripgrep
    {
        'BurntSushi/ripgrep',
    },
    -- Fuzzy Finder: Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons', 
        },
        version = "*",
        config = function()
            require('telescope').setup{
                defaults = {
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case'
                    },
                    prompt_prefix = "> ",
                    selection_caret = "> ",
                    path_display = {"truncate"},
                }
            }
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>pf', function()
                builtin.find_files({})
            end)
            vim.keymap.set('n', '<C-p>', function()
                builtin.git_files({recurse_submodules=true})
            end)
            vim.keymap.set('n', '<leader>ps', function()
                builtin.live_grep({})
            end)
            vim.keymap.set('n', '<F12>', function()
                builtin.lsp_definitions({})
            end)
            vim.keymap.set('n', '<F11>', function()
                builtin.lsp_implementations({})
            end)

        end
    },
    -- Telescope ui
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                }
            })

            require("telescope").load_extension("ui-select")    
        end
    },
}
