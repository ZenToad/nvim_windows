return {
    -- Tool installer and manager
    {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        opts = {},
    },
    
    -- Debug Adapter Protocol (required for rustaceanvim debugging)
    {
        'mfussenegger/nvim-dap',
        lazy = true,
    },
    
    -- Core LSP Configuration (required by rustaceanvim for standard LSP features)
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            -- LSP keybindings (applied when LSP attaches)
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }
                    
                    -- Core LSP keybindings
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', '<leader>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })

            -- Completion setup for auto-completion
            vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
            
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspComplete', {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                    
                    -- Completion keybindings for the buffer
                    local opts = { buffer = ev.buf, silent = true }
                    vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', opts)
                    vim.keymap.set('i', '<C-n>', '<C-x><C-o>', opts) -- Alternative trigger
                    vim.keymap.set('i', '<Tab>', function()
                        if vim.fn.pumvisible() == 1 then
                            return '<C-n>'
                        else
                            return '<Tab>'
                        end
                    end, { buffer = ev.buf, expr = true })
                    vim.keymap.set('i', '<S-Tab>', function()
                        if vim.fn.pumvisible() == 1 then
                            return '<C-p>'
                        else
                            return '<S-Tab>'
                        end
                    end, { buffer = ev.buf, expr = true })
                    vim.keymap.set('i', '<CR>', function()
                        if vim.fn.pumvisible() == 1 then
                            return '<C-y>'
                        else
                            return '<CR>'
                        end
                    end, { buffer = ev.buf, expr = true })
                end,
            })
        end,
    },
}