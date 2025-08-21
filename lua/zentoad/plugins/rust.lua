return {
    -- Modern Rust support - complete zero-config solution
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Use latest recommended version
        lazy = false,
        ft = { 'rust' },
        init = function()
            -- Fix workspace loading issues with standard library
            vim.g.rustaceanvim = {
                server = {
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                            },
                            checkOnSave = true,
                        },
                    },
                },
            }
        end,
        config = function()
            -- Rust-specific keybindings
            vim.keymap.set('n', '<leader>rd', '<cmd>RustLsp debug<cr>', { desc = 'Rust: Start Debug' })
            vim.keymap.set('n', '<leader>rr', '<cmd>RustLsp runnables<cr>', { desc = 'Rust: Runnables' })
        end,
    },
}