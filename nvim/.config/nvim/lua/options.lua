local opt = vim.opt

vim.g.mapleader = " "

opt.number = true
opt.autoindent = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.relativenumber = true
-- opt.cursorcolumn = true
opt.splitbelow = true
opt.splitright = true
opt.cursorline = true
opt.signcolumn = 'yes'
opt.undofile = true

if vim.fn.executable("rg") then
  vim.o.grepprg = "rg --vimgrep --hidden -g !.git"
end
