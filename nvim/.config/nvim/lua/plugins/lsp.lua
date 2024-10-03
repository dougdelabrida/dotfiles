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
        ensure_installed = { "lua_ls", "rust_analyzer", "ts_ls", "elixirls" },
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
        ['ts_ls'] = function()
          lspconfig.ts_ls.setup({
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
                  globals = { 'vim', 'util' },
                },
              },
            },
          }
        end
      })

      local format_is_enabled = true
      vim.api.nvim_create_user_command('FormatToggle', function()
        format_is_enabled = not format_is_enabled
        print('Setting autoformatting to: ' .. tostring(format_is_enabled))
      end, {})

      local _augroups = {}
      local get_augroup = function(client)
        if not _augroups[client.id] then
          local group_name = 'kickstart-lsp-format-' .. client.name
          local id = vim.api.nvim_create_augroup(group_name, { clear = true })
          _augroups[client.id] = id
        end

        return _augroups[client.id]
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
        -- This is where we attach the autoformatting for reasonable clients
        callback = function(args)
          local client_id = args.data.client_id
          local client = vim.lsp.get_client_by_id(client_id)
          local bufnr = args.buf

          -- Only attach to clients that support document formatting
          if not client.server_capabilities.documentFormattingProvider then
            return
          end

          local has_biomejs = vim.fn.filereadable("./biome.json")

          -- Tsserver usually works poorly. Sorry you work with bad languages
          -- You can remove this line if you know what you're doing :)
          if client.name == 'tsserver' and not has_biomejs then
            return
          end

          -- Create an autocmd that will run *before* we save the buffer.
          --  Run the formatting command for the LSP that has just attached.
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = get_augroup(client),
            buffer = bufnr,
            callback = function()
              if not format_is_enabled then
                return
              end

              vim.lsp.buf.format {
                async = false,
                filter = function(c)
                  return c.id == client.id
                end,
              }
            end,
          })
        end,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        lua = { "luacheck" },
        typescript = { "biomejs" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        elixir = { "mix_credo" },
      }
    end
  }
}
