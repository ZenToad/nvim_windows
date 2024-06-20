-- Initialize lazy.nvim
return {
    -- Colorscheme: Kanagawa
    {
        "rebelot/kanagawa.nvim",
        -- lazy = false, -- make sure we load this during startup if it is your main colorscheme
        -- priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.cmd([[colorscheme kanagawa]])
        end,
    },
    -- Icons: Nvim-Web-Devicons
    {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require'nvim-web-devicons'.setup { default = true; }
        end
    },
    -- vim-devicons for NERDTree icons
    {
        'ryanoasis/vim-devicons',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require'nvim-web-devicons'.setup { default = true; }
        end
    },
    -- File Explorer: NERDTree
    {
        "preservim/nerdtree",
        config = function()
            vim.keymap.set("n", "<C-k><C-b>", vim.cmd.NERDTreeToggle)
            vim.keymap.set("i", "<C-k><C-b>", vim.cmd.NERDTreeToggle)
        end,
    },
    -- Terminal: ToggleTerm
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = {
            size = 20,
            open_mapping = [[<c-\>]],
            direction = 'float',
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = 'curved',
                winblend = 3,
            }
        },
        config = function(_, opts)
            require("toggleterm").setup(opts);
        end
    },
    -- Wiki: Vimwiki
    {
        'vimwiki/vimwiki',
        version = "*",
        config = function()
            local home = os.getenv('USERPROFILE')  -- Get the user's home directory
            vim.g.vimwiki_list = {
                {
                    path = home .. '\\vimwiki\\',
                    syntax = 'markdown',  -- can be 'default', 'markdown', 'mediawiki', etc.
                    ext = '.md'           -- file extension for wiki files
                }
            }
            vim.g.vimwiki_ext2syntax = {
                ['.md'] = 'markdown',
                ['.markdown'] = 'markdown',
                ['.mdown'] = 'markdown'
            }
            vim.g.vimwiki_global_ext = 0  -- Only specified extensions will be recognized
        end
    },
    -- TreeSitter textobjects
    {
        'nvim-treesitter/nvim-treesitter-textobjects'
    },
    -- Tree Sitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',  -- This ensures parsers are updated
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query" },  -- List of languages
                auto_install = true,
                highlight = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<Leader>ss", -- selection start
                        node_incremental = "<Leader>si", -- selection increment
                        scope_incremental = "<Leader>sc", -- selection scope
                        node_decremental = "<Leader>sd", -- selection decrement
                    },
                },
                textobjects = {
                    select = {
                      enable = true,
                
                      -- Automatically jump forward to textobj, similar to targets.vim
                      lookahead = true,
                
                      keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        -- You can optionally set descriptions to the mappings (used in the desc parameter of
                        -- nvim_buf_set_keymap) which plugins like which-key display
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        -- You can also use captures from other query groups like `locals.scm`
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                      },
                      -- You can choose the select mode (default is charwise 'v')
                      --
                      -- Can also be a function which gets passed a table with the keys
                      -- * query_string: eg '@function.inner'
                      -- * method: eg 'v' or 'o'
                      -- and should return the mode ('v', 'V', or '<c-v>') or a table
                      -- mapping query_strings to modes.
                      selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V', -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                      },
                      -- If you set this to `true` (default is `false`) then any textobject is
                      -- extended to include preceding or succeeding whitespace. Succeeding
                      -- whitespace has priority in order to act similarly to eg the built-in
                      -- `ap`.
                      --
                      -- Can also be a function which gets passed a table with the keys
                      -- * query_string: eg '@function.inner'
                      -- * selection_mode: eg 'v'
                      -- and should return true or false
                      include_surrounding_whitespace = true,
                    },
                },
            }
        end
    },
    -- Search Tool: Ripgrep
    {
        'BurntSushi/ripgrep',
    },
    -- Fuzzy Finder: Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons', 
        },
        version = "*",
        config = function()
            require('telescope').setup{
                defaults = {
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case'
                    },
                    prompt_prefix = "> ",
                    selection_caret = "> ",
                    path_display = {"truncate"},
                }
            }
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
    },
    -- Telescope ui
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require("telescope").setup({
                extensions = {
                  ["ui-select"] = {
                    require("telescope.themes").get_dropdown {}
                  }
                }
            })

            require("telescope").load_extension("ui-select")    
        end
    },
    -- -- File Navigation: Harpoon
    {
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
    },

    -- Commenting: Nerdcommenter
    {
        'preservim/nerdcommenter',
        config = function()
            vim.g.NERDSpaceDelims = 1
            vim.g.NERDDefaultAlign = 'left'
            vim.g.NERDCommentEmptyLines = 1
            vim.g.NERDTrimTrailingWhitespace = 1
            vim.g.NERDToggleCheckAllLines = 1
            vim.g.NERDAltDelims_c = 1
        end,
    },
    -- Manage ctags
    {
        "ludovicchabant/vim-gutentags",
        config = function()
          vim.g.gutentags_project_root = { '.git', '.hg', '.svn' }
          vim.g.gutentags_ctags_executable = 'ctags'
          vim.g.gutentags_generate_on_write = 1
          vim.g.gutentags_generate_on_missing = 1
        end
      },
    -- Motion: Easymotion
    {
        'easymotion/vim-easymotion',
    },
    -- Tagbar: Tagbar
    {
        'preservim/tagbar',
        config = function()
            vim.keymap.set('n', '<F9>', ':TagbarOpen fj<CR>', {silent = true})
        end
    },
    -- Autocomplete Brackets: DelimitMate
    {
        'Raimondi/delimitMate',
        config = function()
            vim.g.delimitMate_expand_cr = 1
        end
    },
    -- Key Binding Helper: Which-Key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    },
    -- AI Code Completion: Copilot
    {
        'github/copilot.vim',
        -- config = function()
        --     vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
        --         expr = true,
        --         replace_keycodes = false
        --     })
        --     -- vim.g.copilot_no_tab_map = true
        -- end
    },
    -- LSP Installer: Mason
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end,
    },
    -- LSP Config Helper: Mason-LSPConfig
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {'clangd', 'lua_ls', 'tsserver'},
        })
        end
    },
    -- LSP Config: LSPConfig
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup({})
            lspconfig.tsserver.setup({})
            lspconfig.clangd.setup({})
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({'n', 'v'}, '<Leader>cf', vim.lsp.buf.code_action, {})
        end

    },
    -- -- Autocompletion: Nvim-Cmp
    -- {
    --     'hrsh7th/nvim-cmp',
    -- },
    -- -- LSP Source for Nvim-Cmp: Cmp-Nvim-Lsp
    -- {
    --     'hrsh7th/cmp-nvim-lsp'
    -- },
    -- -- Snippets: LuaSnip
    -- {
    --     'L3MON4D3/LuaSnip'
    -- },
    -- -- Rust Support: Rust.Vim
    -- {
    --     'rust-lang/rust.vim',
    --     ft = 'rust',
    --     config = function()
    --         vim.g.rustfmt_autosave = 1
    --     end
    -- },
    -- -- LSP Zero
    -- {
    --     'VonHeikemen/lsp-zero.nvim',
    --     dependencies = {
    --         'neovim/nvim-lspconfig',
    --         'williamboman/mason.nvim',
    --         'williamboman/mason-lspconfig.nvim',
    --         -- Autocompletion
    --         'hrsh7th/nvim-cmp',
    --         'hrsh7th/cmp-nvim-lsp',
    --         'L3MON4D3/LuaSnip',
    --     },
    --     config = function()
    --         local lsp = require('lsp-zero').preset({})

    --         lsp.on_attach(function(client, bufnr)
    --             lsp.default_keymaps({buffer = bufnr})
    --         end)
    --         require('mason-lspconfig').setup({
    --             -- Replace the language servers listed here 
    --             -- with the ones you want to install
    --             ensure_installed = {'pyright', 'tsserver', 'rust_analyzer'},
    --             handlers = {
    --                 lsp.default_setup,
    --             },
    --         })

    --         lsp.configure('clangd', {
    --             cmd = { "clangd", "--compile-commands-dir=path/to/your/compile_commands" },
    --             filetypes = { "c", "cpp", "objc", "objcpp" },
    --             root_dir = function(fname)
    --                 return require('lspconfig').util.root_pattern("compile_commands.json")(fname) or
    --                     require('lspconfig').util.root_pattern(".git")(fname)
    --             end,
    --         })

    --         lsp.setup()
    --         -- You need to setup `cmp` after lsp-zero
    --         local cmp = require('cmp')
    --         local cmp_action = require('lsp-zero').cmp_action()

    --         cmp.setup({
    --             mapping = {
    --                 -- `Enter` key to confirm completion
    --                 ['<CR>'] = cmp.mapping.confirm({select = false}),

    --                 -- Ctrl+Space to trigger completion menu
    --                 ['<C-Space>'] = cmp.mapping.complete(),
    --                 ['<Tab>'] = cmp.mapping(function(fallback)
    --                     if cmp.visible() then
    --                         cmp.select_next_item()
    --                     elseif vim.fn["copilot#Accept"]() ~= "" then
    --                         -- Copilot has a suggestion
    --                     else
    --                         fallback()
    --                     end
    --                 end, {"i", "s"}),

    --                 ['<S-Tab>'] = cmp.mapping(function(fallback)
    --                     if cmp.visible() then
    --                         cmp.select_prev_item()
    --                     else
    --                         fallback()
    --                     end
    --                 end, {'i', 's'}),

    --                 -- Navigate between snippet placeholders
    --                 ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    --                 ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    --             }
    --         })
    --     end
    -- }
}
