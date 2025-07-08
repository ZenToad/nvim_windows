return {
    {'williamboman/mason.nvim'},
    {'jay-babu/mason-nvim-dap.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {
        'VonHeikemen/lsp-zero.nvim', 
        branch = 'v3.x',
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()
            require'lspconfig'.ols.setup {}
            lsp_zero.on_attach(function(client, bufnr)
              -- see :help lsp-zero-keybindings
              -- to learn the available actions
              lsp_zero.default_keymaps({buffer = bufnr})
            end)
            ----------------------------------------------------------------------
            -- 2) one-liner that wipes the default snippet <Tab> binding
            ----------------------------------------------------------------------
            for _, m in ipairs({'i','s'}) do pcall(vim.keymap.del, m, '<Tab>') end

            ----------------------------------------------------------------------
            -- 3) use lsp-zero’s ready-made Supertab preset
            --    • Tab / S-Tab cycle items (or jump placeholders)
            --    • <CR> confirms selection
            --    • Ctrl-Space opens the menu
            ----------------------------------------------------------------------
            lsp_zero.extend_cmp()                 -- brings in cmp-nvim-lsp + defaults
            local cmp        = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                snippet = {                     -- keep built-in snippet support
                    expand = function(args) vim.snippet.expand(args.body) end,
                },
                mapping = {
                    -- Tab  ⇢ next item  |  or jump to next snippet field
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif vim.snippet.active() and vim.snippet.jumpable(1) then
                            vim.snippet.jump(1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    -- Shift-Tab  ⇢ previous item  |  or jump back in snippet
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.snippet.active() and vim.snippet.jumpable(-1) then
                            vim.snippet.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    -- Enter  ⇢ confirm (insert) selected completion
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),

                    -- Ctrl-Space  ⇢ open the completion menu anytime
                    ['<C-Space>'] = cmp.mapping.complete(),
                },

                sources = { { name = 'nvim_lsp' } },
            })            

            require('mason').setup({})
            require('mason-lspconfig').setup({
                -- ensure_installed = {'lua_ls', 'clangd'},
                ensure_installed = {},
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                    clangd = function()
                        require('lspconfig').clangd.setup({
                            cmd = {"clangd"},
                            filetypes = { "c", "cpp", "objc", "objcpp" },
                            root_dir = function(fname)
                                return require('lspconfig').util.root_pattern("compile_commands.json")(fname) or
                                require('lspconfig').util.root_pattern(".git")(fname)
                            end,
                        })
                    end
                },
            })
        end,
    }
}
