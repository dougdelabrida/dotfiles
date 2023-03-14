return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', 'nvim-treesitter/playground' },
  config = function()
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = { 'lua', 'rust', 'typescript' },
      auto_install = true,
      highlight = {
        enable = true
      }
    }
  end
}
