local map = vim.keymap.set

vim.diagnostic.config {
  underline = true,
  virtual_text = true,
  signs = true,
}

-- Sign Icons
local signs = { Error = ' ', Warn = ' ', Hint = ' ' }

-- Consigure signs
for type, icon in pairs(signs) do
  local highlight = "DiagnosticSign" .. type
  vim.fn.sign_define(highlight, { text = icon, texthl = highlight })
end

map('n', '<leader>=', vim.diagnostic.open_float)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '[d', vim.diagnostic.goto_prev)
