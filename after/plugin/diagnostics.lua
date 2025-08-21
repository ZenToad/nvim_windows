-- ===== LSP diagnostics UX =====

-- 1) Clear, consistent visuals
vim.o.signcolumn = "yes"
vim.diagnostic.config({
  virtual_text = true,     -- inline text
  signs = true,            -- gutter icons
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  -- New-style signs (no sign_define)
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN]  = "W",
      [vim.diagnostic.severity.HINT]  = "H",
      [vim.diagnostic.severity.INFO]  = "I",
    },
    -- optional: enable number-column highlights or line highlights
    -- numhl = {
    --   [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
    --   [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
    --   [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
    --   [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
    -- },
    -- linehl = false,
  },
})

-- 2) Auto popup on hover (CursorHold)
vim.o.updatetime = 500  -- default 4000; smaller = faster hover
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    -- Show diagnostics for the current line
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

-- 3) Handy keymaps
-- Jump between diagnostics
vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({count=1}) 
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({count=-1}) 
end, { desc = "Prev diagnostic" })

-- Show popup on demand
vim.keymap.set("n", "<leader>dl", function()
  vim.diagnostic.open_float(nil, { focusable = true })
end, { desc = "Line diagnostics" })

-- Send all diagnostics to quickfix and open it
vim.keymap.set("n", "<leader>dq", function()
  vim.diagnostic.setqflist()
  vim.cmd("copen")
end, { desc = "Diagnostics quickfix" })

-- Toggle location list for current buffer
vim.keymap.set("n", "<leader>do", function()
  -- opens the location list with current buffer diagnostics
  vim.diagnostic.setloclist()
  vim.cmd("lopen")
end, { desc = "Diagnostics (buffer) location list" })

