return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                -- Rust-only development parsers
                ensure_installed = {
                    'rust', 'toml', -- Rust and Cargo.toml support
                    'lua', 'vim', 'vimdoc', -- Neovim config files
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
