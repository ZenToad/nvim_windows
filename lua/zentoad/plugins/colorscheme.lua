return {
    -- Colorscheme: Kanagawa
    -- a
    -- A colorscheme for Neovim inspired by the colors of the Kanagawa wave.
    {
        "rebelot/kanagawa.nvim",
        config = function()
            vim.cmd([[colorscheme kanagawa]])
        end,
    },
}
