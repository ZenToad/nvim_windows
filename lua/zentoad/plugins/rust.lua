return {
    -- Enhanced Rust Development (2025 best practices)
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Updated to latest version
        lazy = false, -- This plugin is already lazy, works out of the box
        -- Removed ft = { 'rust' } as it's automatic
        -- Simplified config - rustaceanvim works out of the box with minimal setup
        config = function()
            vim.g.rustaceanvim = {
                -- Configure rustaceanvim to handle its own debugging
                dap = {
                    adapter = {
                        type = 'executable',
                        command = 'C:\\Program Files\\LLVM\\bin\\lldb-dap.exe',
                        name = 'lldb',
                    },
                },
                server = {
                    on_attach = function(_, bufnr)
                        -- Essential keybindings only
                        vim.keymap.set("n", "<leader>rr", function()
                            vim.cmd.RustLsp('runnables')
                        end, { buffer = bufnr, desc = "Rust runnables" })
                        
                        vim.keymap.set("n", "<leader>rt", function()
                            vim.cmd.RustLsp('testables')
                        end, { buffer = bufnr, desc = "Rust testables" })
                        
                        vim.keymap.set("n", "<leader>rd", function()
                            vim.cmd.RustLsp('debuggables')
                        end, { buffer = bufnr, desc = "Rust debuggables" })
                        
                        vim.keymap.set("n", "<leader>ra", function()
                            vim.cmd.RustLsp('codeAction')
                        end, { buffer = bufnr, desc = "Code actions" })
                    end,
                },
            }
        end,
    },
    -- Cargo.toml management (2025 simplified)
    {
        'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" }, -- Lazy load on Cargo.toml files
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            -- Minimal setup following 2025 best practices
            require('crates').setup({
                -- Essential options only
                completion = {
                    cmp = { enabled = true },
                },
            })
            
            -- Essential keybindings only
            vim.api.nvim_create_autocmd("BufRead", {
                group = vim.api.nvim_create_augroup("CratesMappings", { clear = true }),
                pattern = "Cargo.toml",
                callback = function()
                    local crates = require('crates')
                    local opts = { silent = true, buffer = true }
                    
                    -- Core functionality only
                    vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
                    vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
                    vim.keymap.set("n", "<leader>cu", crates.update_crate, opts)
                    vim.keymap.set("n", "<leader>cH", crates.open_homepage, opts)
                end,
            })
        end,
    },
}