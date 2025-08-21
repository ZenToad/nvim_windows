return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            -- Skip build on Windows to avoid compilation issues
            if vim.fn.has('win32') == 1 then
                return
            else
                return ':TSUpdate'
            end
        end,
        config = function()
            require('nvim-treesitter.configs').setup {
                -- Minimal parser set for Windows compatibility
                ensure_installed = {},  -- Empty - install manually if needed
                
                -- Disable auto features that require compilation
                auto_install = false,
                sync_install = false,
                
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                
                indent = { enable = true },
            }
            
            -- Windows: Skip compilation entirely
            if vim.fn.has('win32') == 1 then
                -- Use built-in vim regex highlighting for now
                vim.cmd([[
                    syntax on
                    filetype plugin indent on
                ]])
            end
        end
    },
}
