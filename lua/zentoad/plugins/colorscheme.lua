return {
    -- Colorscheme: Kanagawa (2025 configuration)
    {
        "rebelot/kanagawa.nvim",
        priority = 1000, -- Ensure it loads first
        config = function()
            require("kanagawa").setup({
                compile = false, -- Enable for faster startup
                undercurl = true,
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true},
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = false,
                dimInactive = false,
                terminalColors = true,
                colors = {
                    palette = {},
                    theme = { wave = {}, lotus = {}, dragon = {}, all = {} }
                },
                theme = "wave", -- Load "wave" theme when 'background' option is not set
                background = {
                    dark = "wave", -- Try "dragon" for a different dark theme
                    light = "lotus" -- Try "lotus" for light theme
                },
            })
            
            -- Set colorscheme
            vim.cmd.colorscheme("kanagawa")
        end,
    },
}
