local telescope = require('telescope')

local keymap = function(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs)
end


keymap("n", "<leader><leader>", ":Telescope find_files<cr>")
keymap("n", "<leader>p", ":Telescope buffers<cr>")
keymap("n", "<leader>lg", ":Telescope live_grep<cr>")
keymap("n", "<leader>gs", ":Telescope grep_string<cr>")
keymap("n", "<leader>gf", ":Telescope git_status<cr>")

telescope.setup {
  defaults = {
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
  },
  pickers = {
    find_files = {
      find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
      layout_config = {
        height = 0.70
      }
    },
    buffers = {
      show_all_buffers = true
    },
  }
}
