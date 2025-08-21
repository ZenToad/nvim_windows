return {
    -- Modern Rust support (2025 standard toolchain)
    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended to pin to major version
        lazy = false,   -- Load immediately for Rust files
        ft = { 'rust' },
        config = function()
            -- rustaceanvim is configured via vim.g.rustaceanvim
            -- No configuration needed - works out of the box with rust-analyzer
            vim.g.rustaceanvim = {
                -- Plugin configuration (optional)
                tools = {
                    -- Automatically set inlay hints (type hints)
                    inlay_hints = {
                        auto = true,
                        show_parameter_hints = true,
                        parameter_hints_prefix = "<- ",
                        other_hints_prefix = "=> ",
                    },
                },
                -- LSP configuration
                server = {
                    -- rust-analyzer settings
                    settings = {
                        ['rust-analyzer'] = {
                            -- Enable all features for better analysis
                            cargo = {
                                allFeatures = true,
                                loadOutDirsFromCheck = true,
                                runBuildScripts = true,
                            },
                            -- Enable proc-macro support
                            procMacro = {
                                enable = true,
                                ignored = {
                                    ["async-trait"] = { "async_trait" },
                                    ["napi-derive"] = { "napi" },
                                    ["async-recursion"] = { "async_recursion" },
                                },
                            },
                            -- Better diagnostics
                            diagnostics = {
                                enable = true,
                                experimental = {
                                    enable = true,
                                },
                            },
                            -- Completion settings
                            completion = {
                                callable = {
                                    snippets = "fill_arguments",
                                },
                            },
                        },
                    },
                },
                -- DAP configuration (debugging)
                dap = {
                    -- Uses system codelldb or lldb-dap
                    -- No manual paths needed
                },
            }
        end,
    },
    
    -- Cargo.toml dependency management
    {
        'saecki/crates.nvim',
        tag = 'stable',
        dependencies = { 'nvim-lua/plenary.nvim' },
        ft = { 'toml' },
        config = function()
            require('crates').setup({
                -- Automatically show crate information
                autoload = true,
                autoupdate = true,
                -- UI settings
                text = {
                    loading = "   Loading...",
                    version = "   %s",
                    prerelease = "   %s",
                    yanked = "   %s yanked",
                    nomatch = "   Not found",
                    upgrade = "   %s",
                    error = "   Error fetching crate",
                },
                highlight = {
                    loading = "CratesNvimLoading",
                    version = "CratesNvimVersion",
                    prerelease = "CratesNvimPreRelease",
                    yanked = "CratesNvimYanked",
                    nomatch = "CratesNvimNoMatch",
                    upgrade = "CratesNvimUpgrade",
                    error = "CratesNvimError",
                },
                popup = {
                    autofocus = true,
                    hide_on_select = true,
                    copy_register = '"',
                    style = "minimal",
                    border = "rounded",
                },
                cmp = {
                    enabled = true,
                },
            })
            
            -- Keybindings for Cargo.toml files
            local opts = { silent = true }
            vim.keymap.set('n', '<leader>ct', require('crates').toggle, opts)
            vim.keymap.set('n', '<leader>cr', require('crates').reload, opts)
            
            vim.keymap.set('n', '<leader>cv', require('crates').show_versions_popup, opts)
            vim.keymap.set('n', '<leader>cf', require('crates').show_features_popup, opts)
            vim.keymap.set('n', '<leader>cd', require('crates').show_dependencies_popup, opts)
            
            vim.keymap.set('n', '<leader>cu', require('crates').update_crate, opts)
            vim.keymap.set('v', '<leader>cu', require('crates').update_crates, opts)
            vim.keymap.set('n', '<leader>ca', require('crates').update_all_crates, opts)
            vim.keymap.set('n', '<leader>cU', require('crates').upgrade_crate, opts)
            vim.keymap.set('v', '<leader>cU', require('crates').upgrade_crates, opts)
            vim.keymap.set('n', '<leader>cA', require('crates').upgrade_all_crates, opts)
            
            vim.keymap.set('n', '<leader>cH', require('crates').open_homepage, opts)
            vim.keymap.set('n', '<leader>cR', require('crates').open_repository, opts)
            vim.keymap.set('n', '<leader>cD', require('crates').open_documentation, opts)
            vim.keymap.set('n', '<leader>cC', require('crates').open_crates_io, opts)
        end,
    },
    
    -- Additional Rust file support
    {
        'rust-lang/rust.vim',
        ft = 'rust',
        config = function()
            -- Enable automatic formatting on save
            vim.g.rustfmt_autosave = 1
            -- Use rust-analyzer for formatting (not rustfmt directly)
            vim.g.rustfmt_command = 'rust-analyzer'
        end,
    },
}