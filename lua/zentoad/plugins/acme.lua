    return {
    -- surround
    {
        'tpope/vim-surround',
    },
    -- File Navigation: Harpoon
    {
        'theprimeagen/harpoon',
        dependencies = 'nvim-lua/plenary.nvim',
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
            -- vim.g.NERDSpaceDelims = 1
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
    },    -- Motion: Easymotion
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
}
