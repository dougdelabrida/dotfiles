vim.lsp.set_log_level 'trace'
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local opts = {buffer = bufnr}
  vim.keymap.set('n', '<cr>', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', '<leader>?', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>,', vim.lsp.buf.code_action, opts)
  vim.api.nvim_create_autocmd('BufWritePre', { buffer = bufnr, callback = vim.lsp.buf.formatting_seq_sync })
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.tsserver.setup({on_attach = on_attach, capabilities = capabilities})
nvim_lsp.elixirls.setup({
  on_attach = on_attach,
  cmd = {
    vim.loop.os_homedir() .. "/.local/share/elixir-ls/rel/language_server.sh"
  },
  capabilities = capabilities
})
nvim_lsp.rust_analyzer.setup({on_attach = on_attach, capabilities = capabilities})

