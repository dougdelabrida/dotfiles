local telescope = require('telescope')
 
vim.keymap.set("n", "<leader><leader>", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>p", ":Telescope buffers<cr>")
vim.keymap.set("n", "<leader>lg", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>gs", ":Telescope grep_string<cr>")

telescope.setup{
  defaults = {
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
  },
  pickers = {
    find_files = {
      find_command = {'rg', '--files', '--hidden', '-g', '!.git'},
      layout_config = {
        height = 0.70
      }
    },
    buffers = {
      show_all_buffers = true
    },
  }
}

