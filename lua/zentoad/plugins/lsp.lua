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
        config = function()
            local dap = require('dap')
            
            -- Standard debugging keybindings
            vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
            vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
            vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
            vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
            vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
            vim.keymap.set('n', '<S-F5>', dap.terminate, { desc = 'Debug: Terminate' })
            
            -- Additional useful keybindings
            vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
            vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Continue' })
            vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'Debug: Open REPL' })
            
            -- Variable inspection (best practice: hover and visual eval)
            vim.keymap.set('n', '<leader>dh', function()
                local widgets = require('dap.ui.widgets')
                widgets.hover(nil, { winopts = { border = 'rounded' } })
            end, { desc = 'Debug: Hover Variables' })
            vim.keymap.set('v', '<leader>dh', function()
                local widgets = require('dap.ui.widgets')
                widgets.visual_hover(nil, { winopts = { border = 'rounded' } })
            end, { desc = 'Debug: Hover Variables (Visual)' })
            
            -- Close hover windows with Escape
            vim.keymap.set('n', '<Esc>', function()
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    local buf_name = vim.api.nvim_buf_get_name(buf)
                    if buf_name:match('dap%-hover') then
                        vim.api.nvim_win_close(win, true)
                    end
                end
            end, { desc = 'Close DAP hover windows' })
            
            -- Callstack and scopes inspection
            vim.keymap.set('n', '<leader>ds', function()
                local widgets = require('dap.ui.widgets')
                widgets.sidebar(widgets.scopes).open()
            end, { desc = 'Debug: Scopes' })
            vim.keymap.set('n', '<leader>df', function()
                local widgets = require('dap.ui.widgets')
                widgets.sidebar(widgets.frames).open()
            end, { desc = 'Debug: Frames (Callstack)' })
        end,
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