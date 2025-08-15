    return {
    -- surround
    {
        'tpope/vim-surround',
    },
    -- File Navigation: Harpoon
    {
        'theprimeagen/harpoon',
        branch = "harpoon2",
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup({})
            vim.keymap.set("n", "<leader>a", function () harpoon:list():add() end)

            -- basic telescope configuration
            --local conf = require("telescope.config").values
            --local function toggle_telescope(harpoon_files)
            --    local file_paths = {}
            --    for _, item in ipairs(harpoon_files.items) do
            --        table.insert(file_paths, item.value)
            --    end
            --
            --    require("telescope.pickers").new({}, {
            --        prompt_title = "Harpoon",
            --        finder = require("telescope.finders").new_table({
            --            results = file_paths,
            --        }),
            --        previewer = conf.file_previewer({}),
            --        sorter = conf.generic_sorter({}),
            --    }):find()
            --end
            --
            --  vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
             vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<F1>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<F2>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<F3>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<F4>", function() harpoon:list():select(4) end)

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
