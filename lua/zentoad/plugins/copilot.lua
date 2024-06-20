return {
    {
        'zbirenbaum/copilot.lua',
        config = function()
            require('copilot').setup({
                suggestion = {enabled = false},
                panel = {enabled = false},
            })
            local cmp = require('cmp')

            cmp.setup({
                sources = {
                    {name = 'copilot'},
                    {name = 'nvim_lsp'},
                },
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({
                        -- documentation says this is important.
                        -- I don't know why.
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    })
                })
            })
            local has_words_before = function()
                if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then return false end
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
            end
            cmp.setup({
                mapping = {
                    ["<Tab>"] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end),
                },
            })
        end
    },
    {
        'zbirenbaum/copilot-cmp',
        config = function()
            require('copilot_cmp').setup()
        end
    },
}
