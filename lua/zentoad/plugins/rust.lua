return {
    -- Enhanced Rust Development
    {
        'mrcjkb/rustaceanvim',
        version = '^5',
        lazy = false,
        ft = { 'rust' },
        config = function()
            vim.g.rustaceanvim = {
                inlay_hints = {
                    highlight = "NonText",
                },
                tools = {
                    hover_actions = {
                        auto_focus = true,
                    },
                },
                server = {
                    on_attach = function(client, bufnr)
                        -- Custom keybindings for Rust
                        vim.keymap.set("n", "<leader>rr", function()
                            vim.cmd.RustLsp('runnables')
                        end, { buffer = bufnr, desc = "Rust runnables" })
                        
                        vim.keymap.set("n", "<leader>rt", function()
                            vim.cmd.RustLsp('testables')
                        end, { buffer = bufnr, desc = "Rust testables" })
                        
                        vim.keymap.set("n", "<leader>rd", function()
                            vim.cmd.RustLsp('debuggables')
                        end, { buffer = bufnr, desc = "Rust debuggables" })
                        
                        vim.keymap.set("n", "<leader>re", function()
                            vim.cmd.RustLsp('expandMacro')
                        end, { buffer = bufnr, desc = "Expand macro" })
                        
                        vim.keymap.set("n", "<leader>rc", function()
                            vim.cmd.RustLsp('openCargo')
                        end, { buffer = bufnr, desc = "Open Cargo.toml" })
                        
                        vim.keymap.set("n", "<leader>rp", function()
                            vim.cmd.RustLsp('parentModule')
                        end, { buffer = bufnr, desc = "Parent module" })
                        
                        vim.keymap.set("n", "K", function()
                            vim.cmd.RustLsp({ 'hover', 'actions' })
                        end, { buffer = bufnr, desc = "Hover actions" })
                        
                        vim.keymap.set("n", "<leader>ra", function()
                            vim.cmd.RustLsp('codeAction')
                        end, { buffer = bufnr, desc = "Code actions" })
                    end,
                },
            }
        end,
    },
    -- Cargo.toml management
    {
        'saecki/crates.nvim',
        tag = 'stable',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup({
                smart_insert = true,
                insert_closing_quote = true,
                autoload = true,
                autoupdate = true,
                loading_indicator = true,
                date_format = "%Y-%m-%d",
                thousands_separator = ".",
                notification_title = "Crates",
                curl_args = { "-sL", "--retry", "1" },
                max_parallel_requests = 80,
                expand_crate_moves_cursor = true,
                enable_update_available_warning = true,
                on_attach = function(bufnr)
                    local crates = require('crates')
                    local opts = { silent = true, buffer = bufnr }
                    
                    vim.keymap.set("n", "<leader>ct", crates.toggle, opts)
                    vim.keymap.set("n", "<leader>cr", crates.reload, opts)
                    
                    vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
                    vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
                    vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)
                    
                    vim.keymap.set("n", "<leader>cu", crates.update_crate, opts)
                    vim.keymap.set("v", "<leader>cu", crates.update_crates, opts)
                    vim.keymap.set("n", "<leader>ca", crates.update_all_crates, opts)
                    vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, opts)
                    vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, opts)
                    vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, opts)
                    
                    vim.keymap.set("n", "<leader>ce", crates.expand_plain_crate_to_inline_table, opts)
                    vim.keymap.set("n", "<leader>cE", crates.extract_crate_into_table, opts)
                    
                    vim.keymap.set("n", "<leader>cH", crates.open_homepage, opts)
                    vim.keymap.set("n", "<leader>cR", crates.open_repository, opts)
                    vim.keymap.set("n", "<leader>cD", crates.open_documentation, opts)
                    vim.keymap.set("n", "<leader>cC", crates.open_crates_io, opts)
                end,
            })
        end,
    },
}