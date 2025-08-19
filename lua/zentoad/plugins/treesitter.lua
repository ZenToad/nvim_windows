return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                -- Essential parsers for multi-language development (2025)
                ensure_installed = {
                    'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query', 
                    'rust', 'toml', -- Rust support
                    'markdown', 'markdown_inline', -- Documentation
                    'json', 'yaml', -- Config files
                    'bash', 'python', -- Common scripting
                },

                -- Auto-install missing parsers (2025 recommendation: true for better UX)
                auto_install = true,
                sync_install = false,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false, -- Better performance
                },
                
                -- Modern 2025 features
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },
            }
            
            -- Windows-specific compiler setup
            if vim.fn.has('win32') == 1 then
                require('nvim-treesitter.install').compilers = { "clang", "gcc" }
            end
        end
    },
}
