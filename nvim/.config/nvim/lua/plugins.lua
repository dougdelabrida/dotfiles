-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'kyazdani42/nvim-web-devicons'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('fuzzy')
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require("nvim-tree").setup()
    end,
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  use 'elixir-editors/vim-elixir'

  use 'vyperlang/vim-vyper' 

  -- appeareance
  -- theme

  use {
    'projekt0n/github-nvim-theme',
    config = function()
      require('github-theme').setup({
        theme_style = 'dark',
        dark_float = true
      })
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = { 'nvim-treesitter/nvim-treesitter-textobjects', 'nvim-treesitter/playground' },
    config = function() require("tree-sitter") end
  }

  -- TODO: define
  use 'yuttie/comfortable-motion.vim'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      require('git')
    end
  }

  -- Language server

  use {
    'neovim/nvim-lspconfig',
    config = function()
      require('lsp')
    end
  }

  -- autcomplete

  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require('cmp_setup')   
    end
  }

 -- formatter
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('formatter') 
    end
  }

  -- utils
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup()
    end
  }
  use {
    'folke/trouble.nvim',
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup() 
    end
  }
  use {
    'christoomey/vim-tmux-navigator',
    config = function ()
      vim.g.tmux_navigator_disable_when_zoomed = true
    end
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup() 
    end
  }
end)
