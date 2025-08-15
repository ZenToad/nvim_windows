return {
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    config = function()
      -- ensure .odin files are recognized
      vim.filetype.add({ extension = { odin = "odin" } })

      local lspconfig = require('lspconfig')
      local util      = require('lspconfig.util')
      local lsp_zero  = require('lsp-zero')

      lsp_zero.extend_lspconfig()
      lsp_zero.on_attach(function(_, bufnr)
        lsp_zero.default_keymaps({buffer = bufnr})
      end)

      -- completion (unchanged)
      local cmp = require('cmp')
      lsp_zero.extend_cmp()
      for _, m in ipairs({'i','s'}) do pcall(vim.keymap.del, m, '<Tab>') end
      cmp.setup({
        snippet = { expand = function(args) vim.snippet.expand(args.body) end },
        mapping = {
          ['<Tab>']   = cmp.mapping(function(fb) if cmp.visible() then cmp.select_next_item()
            elseif vim.snippet.active() and vim.snippet.jumpable(1) then vim.snippet.jump(1) else fb() end end, {'i','s'}),
          ['<S-Tab>'] = cmp.mapping(function(fb) if cmp.visible() then cmp.select_prev_item()
            elseif vim.snippet.active() and vim.snippet.jumpable(-1) then vim.snippet.jump(-1) else fb() end end, {'i','s'}),
          ['<CR>']    = cmp.mapping.confirm({ select = true }),
          ['<C-Space>']= cmp.mapping.complete(),
        },
        sources = { { name = 'nvim_lsp' } },
      })

      -- mason for other servers (clangd, etc.)
      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {},
        handlers = {
          function(server) lspconfig[server].setup({}) end,
          clangd = function()
            lspconfig.clangd.setup({
              cmd = { "clangd" },
              root_dir = function(fname)
                return util.root_pattern("compile_commands.json", ".git")(fname)
              end,
            })
          end,
        },
      })

      -- 🔹 Explicit OLS setup (NOT via mason)
      lspconfig.ols.setup({
        cmd = { "C:\\dev\\ols\\ols.exe" }, -- absolute path is safest on Windows
        filetypes = { "odin" },
        root_dir = function(fname)
          return util.root_pattern("ols.json", ".git")(fname) or util.path.dirname(fname)
        end,
        on_new_config = function(cfg, _)
          cfg.cmd_env = vim.tbl_extend('force', cfg.cmd_env or {}, {
            ODIN_ROOT = vim.fn.getenv("ODIN_ROOT"),
            PATH      = vim.fn.getenv("PATH"),
          })
        end,
      })
    end,
  }
}

