
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
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({search = vim.fn.input("Grep > ")})
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
},{
    'neovim/nvim-lspconfig',
    dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    },
    -- config = function()
    -- (Optional) Configure lua language server for neovim
    -- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
    -- end
},{                                      -- Optional
    'williamboman/mason.nvim',
    config = function()
        -- pcall(vim.cmd, 'MasonUpdate')
        require('mason').setup({})
    end,
},{
    'williamboman/mason-lspconfig.nvim',
},{
    'hrsh7th/nvim-cmp' -- Required
},{
    'hrsh7th/cmp-nvim-lsp'
},{
    'L3MON4D3/LuaSnip'
},{
    'github/copilot.vim',
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
            ensure_installed = {'tsserver', 'rust_analyzer'},
            handlers = {
                lsp.default_setup,
            },
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


