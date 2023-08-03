return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("mason").setup({
        ui = { border = 'single' }
      })

      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "tsserver", "elixirls" },
      })

      vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        float = {
          border = 'single',
          source = 'always',
          header = '',
          prefix = '',
        },
      })

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = 'single' }
      )

      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = 'single' }
      )

      vim.api.nvim_create_autocmd('User', {
        pattern = 'LspAttached',
        callback = function(args)
          local buffer = args.buffer

          local keymap = function(mode, lhs, rhs)
            local opts = { buffer = buffer }
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          keymap('n', '<cr>', vim.lsp.buf.definition)
          keymap('n', '<leader>?', vim.lsp.buf.signature_help)
          keymap('n', '<leader>h', '<cmd>lua vim.lsp.buf.hover()<cr>')
          keymap('n', '<leader>,', vim.lsp.buf.code_action)
          keymap('n', '<leader>r', vim.lsp.buf.rename)
          keymap('n', '<leader>lo', '<CMD>Telescope lsp_document_symbols<cr>')
        end
      })

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      local lspconfig = require('lspconfig')

      local on_attach = function(client, bufnr)
        -- Link to the commands created previously
        vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
        -- Ensure auto formatting before when saving
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end

      local lsp_defaults = {
        flags = {
          debounce_text_changes = 150,
        },
        capabilities = require('cmp_nvim_lsp').default_capabilities(
          vim.lsp.protocol.make_client_capabilities()
        ),
        on_attach = on_attach
      }

      lspconfig.util.default_config = vim.tbl_deep_extend(
        'force',
        lspconfig.util.default_config,
        lsp_defaults
      )

      local default_handler = function(server)
        lspconfig[server].setup({})
      end

      mason_lspconfig.setup_handlers({
        default_handler,
        ['tsserver'] = function()
          lspconfig.tsserver.setup({
            settings = {
              completions = {
                completeFunctionCalls = true
              }
            }
          })
        end,
        ["lua_ls"] = function()
          lspconfig["lua_ls"].setup {
            settings = {
              Lua = {
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { 'vim' },
                },
              },
            },
          }
        end
      })
    end
  }
}
