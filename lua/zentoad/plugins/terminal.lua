return {
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
}
