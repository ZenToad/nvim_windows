
return {{
    "rebelot/kanagawa.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        vim.cmd([[colorscheme kanagawa]])
    end,
},{
    "preservim/nerdtree",
    config = function()
        vim.keymap.set("n", "<C-k><C-b>", vim.cmd.NERDTreeToggle)
        vim.keymap.set("i", "<C-k><C-b>", vim.cmd.NERDTreeToggle)
    end,
},{
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup {
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = '1',
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = 'float',
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = 'curved',
                winblend = 0,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                }
            }
        }
    end,
},{
    'vimwiki/vimwiki', 
    config = function()
        vim.g.vimwiki_list = {
            {
                path = '~/sequre-wiki',
                nested_syntaxes = {python = 'python', ['c++'] = 'cpp'}
            },
        }
    end
},{
    'BurntSushi/ripgrep',
},{
    'nvim-telescope/telescope.nvim',
    dependencies = { 
        'nvim-lua/plenary.nvim',
        'BurntSushi/ripgrep',
    },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', function()
            builtin.find_files({})
        end)
        vim.keymap.set('n', '<C-p>', function()
            builtin.git_files({recurse_submodules=true})
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.live_grep({})
        end)
        vim.keymap.set('n', '<F12>', function()
            builtin.lsp_definitions({})
        end)
        vim.keymap.set('n', '<F11>', function()
            builtin.lsp_implementations({})
        end)
    end
},{
    'nvim-treesitter/nvim-treesitter',
    opts = {
        run = ':TSUpdate',
    }
},{
    'theprimeagen/harpoon',
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<leader>a", mark.add_file)
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

        vim.keymap.set("n", "<C-1>", function() ui.nav_file(1) end)
        vim.keymap.set("n", "<C-2>", function() ui.nav_file(2) end)
        vim.keymap.set("n", "<C-3>", function() ui.nav_file(3) end)
        vim.keymap.set("n", "<C-4>", function() ui.nav_file(4) end)
    end
},{
    'mbbill/undotree',
    config = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle) 
    end
},{
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end
},{
    'preservim/nerdcommenter',
    config = function()
        vim.g.NERDSpaceDelims = 1
        vim.g.NERDDefaultAlign = 'left'
        
        -- Allow commenting and inverting empty lines (useful when commenting a region)
        vim.g.NERDCommentEmptyLines = 1
        
        -- Enable trimming of trailing whitespace when uncommenting
        vim.g.NERDTrimTrailingWhitespace = 1
        
        -- Enable NERDCommenterToggle to check all selected lines is commented or not 
        vim.g.NERDToggleCheckAllLines = 1
        
        -- Use alternate comment style
        vim.g.NERDAltDelims_c = 1
    end,
},{
    'easymotion/vim-easymotion',
},{
    'preservim/tagbar',
    config = function()
        vim.keymap.set('n', '<F9>', ':TagbarOpen fj<CR>', {silent = true})
    end
},{
    'Raimondi/delimitMate',
    config = function()
        vim.g.delimitMate_expand_cr=1
    end
},{                                      -- Optional
    'williamboman/mason.nvim',
    config = function()
        -- pcall(vim.cmd, 'MasonUpdate')
        require('mason').setup({})
    end,
},{
    'williamboman/mason-lspconfig.nvim',
},{
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    },
    -- config = function()
    --     require('lspconfig').pyright.setup{}
    -- end
},{
    'hrsh7th/nvim-cmp' -- Required
},{
    'hrsh7th/cmp-nvim-lsp'
},{
    'L3MON4D3/LuaSnip'
},{
    'github/copilot.vim',
    config = function()
        vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
          expr = true,
          replace_keycodes = false
        })
        vim.g.copilot_no_tab_map = tru
    end
},{
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
},{
    'rust-lang/rust.vim',
    ft = 'rust',
    config = function()
        vim.g.rustfmt_autosave = 1
    end
},{
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
    },
    config = function()
        local lsp = require('lsp-zero').preset({})

        lsp.on_attach(function(client, bufnr)
          lsp.default_keymaps({buffer = bufnr})
        end)
        require('mason-lspconfig').setup({
            -- Replace the language servers listed here 
            -- with the ones you want to install
            ensure_installed = {'pyright', 'tsserver', 'rust_analyzer'},
            handlers = {
                lsp.default_setup,
            },
        })

        lsp.configure('clangd', {
          cmd = { "clangd", "--compile-commands-dir=path/to/your/compile_commands" },
          filetypes = { "c", "cpp", "objc", "objcpp" },
          root_dir = function(fname)
            return require('lspconfig').util.root_pattern("compile_commands.json")(fname) or
                   require('lspconfig').util.root_pattern(".git")(fname)
          end,
        })

        lsp.setup()
        -- You need to setup `cmp` after lsp-zero
        local cmp = require('cmp')
        local cmp_action = require('lsp-zero').cmp_action()

        cmp.setup({
          mapping = {
            -- `Enter` key to confirm completion
            ['<CR>'] = cmp.mapping.confirm({select = false}),

            -- Ctrl+Space to trigger completion menu
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),

            -- Navigate between snippet placeholder
            ['<C-f>'] = cmp_action.luasnip_jump_forward(),
            ['<C-b>'] = cmp_action.luasnip_jump_backward(),
          }
        })
    end
}}


