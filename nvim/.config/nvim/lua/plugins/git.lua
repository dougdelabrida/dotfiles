return {
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local gitsigns = require('gitsigns')

      gitsigns.setup {
        on_attach = function(bufnr)
          local function map(mode, lhs, rhs, opts)
            opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
          end

          map('n', ']g', '<cmd>lua require\"gitsigns\".next_hunk()<CR>zz')
          map('n', '[g', '<cmd>lua require\"gitsigns\".prev_hunk()<CR>zz')
          map('n', '<leader>g+', '<cmd>lua require"gitsigns".stage_hunk()<CR>')
          map('n', '<leader>g-', '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>')
          map('n', '<leader>g=', '<cmd>lua require"gitsigns".reset_hunk()<CR>')
          map('n', '<leader>gp', '<cmd>lua require"gitsigns".preview_hunk()<CR>')
          map('n', '<leader>gb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
          map('n', '<leader>Tb', '<cmd>lua require"gitsigns".toggle_current_line_blame()<CR>')
          map('n', '<leader>hd', '<cmd>lua require"gitsigns".diffthis()<CR>')
          map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
          map('n', '<leader>Td', '<cmd>lua require"gitsigns".toggle_deleted()<CR>')
        end
      }
    end
  }
}
