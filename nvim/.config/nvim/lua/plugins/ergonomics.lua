return {
  "yuttie/comfortable-motion.vim",
  "tpope/vim-fugitive",
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
    end,
    dependencies = { "kyazdani42/nvim-web-devicons" }
  },
  -- Utils
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight"
        }
      })
    end
  },
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end
  },
  "folke/lsp-colors.nvim",
  {
    "christoomey/vim-tmux-navigator",
    config = function()
      vim.g.tmux_navigator_disable_when_zoomed = true
    end
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end
  },
}
