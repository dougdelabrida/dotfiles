require'nvim-treesitter.configs'.setup {
  ensure_installed = { 'lua', 'rust', 'typescript'},
  auto_install = true,
  highlight = {
    enable = true
  }
}

