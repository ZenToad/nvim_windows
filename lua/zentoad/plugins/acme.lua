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
    -- Commenting: Comment.nvim (modern replacement for nerdcommenter)
    {
        'numToStr/Comment.nvim',
        keys = {
            { "gcc", mode = "n", desc = "Comment toggle current line" },
            { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
            { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
            { "gbc", mode = "n", desc = "Comment toggle current block" },
            { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
            { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
        },
        config = function()
            require('Comment').setup({
                -- Add a space b/w comment and the line
                padding = true,
                -- Whether the cursor should stay at its position
                sticky = true,
                -- Lines to be ignored while (un)comment
                ignore = nil,
                -- LHS of toggle mappings in NORMAL mode
                toggler = {
                    line = 'gcc',      -- Line-comment toggle keymap
                    block = 'gbc',     -- Block-comment toggle keymap
                },
                -- LHS of operator-pending mappings in NORMAL and VISUAL mode
                opleader = {
                    line = 'gc',       -- Line-comment keymap
                    block = 'gb',      -- Block-comment keymap
                },
                -- LHS of extra mappings
                extra = {
                    above = 'gcO',     -- Add comment on the line above
                    below = 'gco',     -- Add comment on the line below
                    eol = 'gcA',       -- Add comment at the end of line
                },
                -- Enable keybindings
                mappings = {
                    basic = true,      -- Operator-pending mapping
                    extra = true,      -- Extra mapping
                },
            })
        end,
    },
    -- Motion: Flash.nvim (modern EasyMotion replacement)
    {
        'folke/flash.nvim',
        event = "VeryLazy",
        opts = {
            -- Flash configuration
            labels = "asdfghjklqwertyuiopzxcvbnm",
            search = {
                multi_window = true,
                forward = true,
                wrap = true,
                mode = "exact", -- exact|search|fuzzy
            },
            jump = {
                jumplist = true,
                pos = "start", -- start|end|middle
                history = false,
                register = false,
            },
            label = {
                uppercase = true,
                exclude = "",
                current = true,
                after = true,
                before = false,
                style = "overlay", -- overlay|eol|right_align|inline
            },
            highlight = {
                backdrop = true,
                matches = true,
            },
            modes = {
                search = {
                    enabled = true,
                },
                char = {
                    enabled = true,
                    jump_labels = true,
                },
            },
        },
        keys = {
            -- Flash navigation keybindings (avoiding conflicts with native Vim commands)
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "<leader>s", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
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
