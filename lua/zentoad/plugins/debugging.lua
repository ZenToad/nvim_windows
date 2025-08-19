return {
    -- nvim-dap
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'nvim-neotest/nvim-nio',  -- Ensure nvim-nio is installed
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')

            dap.set_log_level('TRACE')
    --
            -- LLDB adapter for C/C++ and Rust
            dap.adapters.lldb = {
                type = 'executable',
                command = 'C:\\Program Files\\LLVM\\bin\\lldb-dap.exe',
                name = 'lldb'
            }
            
            -- CodeLLDB adapter for better Rust support
            dap.adapters.codelldb = {
                type = 'server',
                port = '${port}',
                executable = {
                    command = 'codelldb',
                    args = { '--port', '${port}' },
                }
            }
            -- C/C++ configurations
            dap.configurations.cpp = {
                {
                    name = 'Launch',
                    type = 'lldb',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    args = {},
                    runInTerminal = false,
                },
            }
            dap.configurations.c = dap.configurations.cpp
            
            -- Rust configurations
            dap.configurations.rust = {
                {
                    name = 'Launch Rust',
                    type = 'codelldb',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    args = {},
                    runInTerminal = false,
                },
                {
                    name = 'Launch Rust (cargo)',
                    type = 'codelldb',
                    request = 'launch',
                    cargo = {
                        args = { 'build', '--bin=' .. vim.fn.expand('%:t:r') },
                        filter = {
                            name = vim.fn.expand('%:t:r'),
                            kind = 'bin',
                        },
                    },
                    args = {},
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                },
            }
    --
            -- Enable virtual text for variable values
            require('nvim-dap-virtual-text').setup()

            -- Set up DAP UI
            dapui.setup()
    --
            -- Keybindings for DAP (Note: F5 conflicts with build, using different keys)
            vim.keymap.set('n', '<F6>', function() dap.continue() end, { desc = 'Debug: Continue' })
            vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = 'Debug: Step Over' })
            vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = 'Debug: Step Into' })
            vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = 'Debug: Step Out' })
            vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })
            vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'Debug: Conditional Breakpoint' })
            vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end, { desc = 'Debug: Open REPL' })
            vim.keymap.set('n', '<leader>dl', function() dap.run_last() end, { desc = 'Debug: Run Last' })
    --
            -- Open the DAP UI automatically when debugging starts
            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end

            -- Close the DAP UI automatically when debugging stops
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
            end
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap' }
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        dependencies = { 'mfussenegger/nvim-dap' }
    },
    {
        'nvim-neotest/nvim-nio'
    },
}
