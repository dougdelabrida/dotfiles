local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
-- go to previous buffer
map('n', '<bs>', ':b#<CR>')
map('n', '<leader>t', ':NvimTreeToggle<CR>', opts)
map('v', '<leader>c', '"+y')
-- quick fix list
map('n', '<UP>', '<CMD>cope<CR>')
map('n', '<DOWN>', '<CMD>cclose<CR>')
map('n', '<RIGHT>', '<CMD>cnext<CR>')
map('n', '<LEFT>', '<CMD>cprev<CR>')
map('n', '<leader>/', ':silent grep ')
-- make search life easier
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', '*', '*zz')
map('n', '#', '#zz')
