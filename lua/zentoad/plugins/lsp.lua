return {
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
    {
        'VonHeikemen/lsp-zero.nvim', 
        branch = 'v3.x',
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
              -- see :help lsp-zero-keybindings
              -- to learn the available actions
              lsp_zero.default_keymaps({buffer = bufnr})
            end)

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
