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
      require('nvim-tree').setup()
    end,
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- appeareance
  -- theme

  use 'folke/tokyonight.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = { 'nvim-treesitter/nvim-treesitter-textobjects', 'nvim-treesitter/playground' },
    config = function() require('tree-sitter') end
  }

  -- TODO: define
  use 'yuttie/comfortable-motion.vim'
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('git')
    end
  }

  -- Language server
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  }

  -- autcomplete & snippets

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/vim-vsnip-integ',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      require('cmp-setup')
      require('lsp')
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
      require('lualine').setup({
        options = {
          theme = 'tokyonight'
        }
      })
    end
  }
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup()
    end
  }

  use 'folke/lsp-colors.nvim'

  use {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.g.tmux_navigator_disable_when_zoomed = true
    end
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }
  use 'tpope/vim-fugitive'
end)
