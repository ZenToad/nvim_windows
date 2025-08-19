return {
    -- Mason DAP support
    {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            require('mason-nvim-dap').setup({
                ensure_installed = { 'codelldb' },
                handlers = {
                    function(config)
                        require('mason-nvim-dap').default_setup(config)
                    end,
                    codelldb = function(config)
                        -- Get the actual Mason install path for codelldb
                        local mason_registry = require('mason-registry')
                        local codelldb_path = "codelldb" -- fallback
                        
                        if mason_registry.is_installed('codelldb') then
                            local install_path = mason_registry.get_package('codelldb'):get_install_path()
                            print("CodeLLDB install path: " .. install_path)
                            
                            if vim.fn.has('win32') == 1 then
                                -- Try the actual Windows path structure
                                local possible_paths = {
                                    install_path .. "\\extension\\adapter\\codelldb.exe",
                                    install_path .. "\\codelldb.exe",
                                }
                                for _, path in ipairs(possible_paths) do
                                    print("Checking path: " .. path)
                                    if vim.fn.executable(path) == 1 then
                                        codelldb_path = path
                                        print("Found working codelldb at: " .. path)
                                        break
                                    end
                                end
                            else
                                codelldb_path = install_path .. "/extension/adapter/codelldb"
                            end
                        else
                            print("CodeLLDB not installed via Mason")
                        end
                        
                        print("Using codelldb command: " .. codelldb_path)
                        
                        config.adapters = {
                            type = "server",
                            port = "${port}",
                            executable = {
                                command = codelldb_path,
                                args = {"--port", "${port}"}
                            }
                        }
                        require('mason-nvim-dap').default_setup(config)
                    end
                }
            })
        end,
    },
    -- nvim-dap
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'nvim-neotest/nvim-nio',  -- Ensure nvim-nio is installed
            'jay-babu/mason-nvim-dap.nvim',
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')

            dap.set_log_level('TRACE')
    --
            -- LLDB adapter for C/C++ 
            dap.adapters.lldb = {
                type = 'executable',
                command = 'C:\\Program Files\\LLVM\\bin\\lldb-dap.exe',
                name = 'lldb'
            }
            
            -- CodeLLDB adapter is now automatically configured by mason-nvim-dap
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
