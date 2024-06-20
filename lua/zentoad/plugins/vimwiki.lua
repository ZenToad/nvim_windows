return {
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
}
