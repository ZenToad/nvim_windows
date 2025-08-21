    return {
    -- Surround: nvim-surround (modern replacement with better UX)
    {
        'kylechui/nvim-surround',
        version = "*", -- Use for stability; omit to use `main` branch for latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
                keymaps = {
                    insert = "<C-g>s",
                    insert_line = "<C-g>S",
                    normal = "ys",
                    normal_cur = "yss",
                    normal_line = "yS",
                    normal_cur_line = "ySS",
                    visual = "S",
                    visual_line = "gS",
                    delete = "ds",
                    change = "cs",
                    change_line = "cS",
                },
                -- Add custom surrounds
                surrounds = {
                    -- Custom surround for function calls
                    ["f"] = {
                        add = function()
                            local result = require("nvim-surround.config").get_input("Enter the function name: ")
                            if result then
                                return { { result .. "(" }, { ")" } }
                            end
                        end,
                        find = "[%w_]+%b()",
                        delete = "^([%w_]+%()().-(%))()$",
                        change = {
                            target = "^([%w_]+)()%(.-%)()()$",
                            replacement = function()
                                local result = require("nvim-surround.config").get_input("Enter the function name: ")
                                if result then
                                    return { { result }, { "" } }
                                end
                            end,
                        },
                    },
                },
                -- Highlight configuration
                highlight = {
                    duration = 2000,
                },
            })
        end,
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
    -- Autocomplete Brackets: nvim-autopairs (modern replacement for delimitMate)
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            
            npairs.setup({
                check_ts = true,                    -- Enable treesitter integration
                ts_config = {
                    lua = {'string', 'source'},     -- Don't add pairs in lua string treesitter nodes
                    javascript = {'string', 'template_string'},
                    java = false,                   -- Don't check treesitter in java
                },
                disable_filetype = { "TelescopePrompt", "vim" },
                disable_in_macro = false,           -- Disable when recording or executing a macro
                disable_in_visualblock = false,     -- Disable when insert after visual block mode
                disable_in_replace_mode = true,
                ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
                enable_moveright = true,
                enable_afterquote = true,           -- Add bracket pairs after quote
                enable_check_bracket_line = true,   -- Check bracket in same line
                enable_bracket_in_quote = true,
                enable_abbr = false,                -- Trigger abbreviation
                break_undo = true,                  -- Switch for basic rule break undo sequence
                check_comma = true,
                map_cr = true,
                map_bs = true,                      -- Map the <BS> key
                map_c_h = false,                    -- Map the <C-h> key to delete a pair
                map_c_w = false,                    -- Map <c-w> to delete a pair if possible
            })
            
            -- Integration with nvim-cmp if available (optional)
            local ok, cmp = pcall(require, 'cmp')
            if ok then
                local cmp_autopairs = require('nvim-autopairs.completion.cmp')
                cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
            end
        end,
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
