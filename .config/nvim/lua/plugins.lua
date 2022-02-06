local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Automatically re-run PackerCompile when the plugins file changes
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- allows for splitting and joining multiline statements
  use 'AndrewRadev/splitjoin.vim'

  -- keep HTML tags in sync
  use 'AndrewRadev/tagalong.vim'

  -- show where we are in the code
  use {
    "SmiteshP/nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require('nvim-gps').setup()
    end
  }

  -- tab completion
  use {
    {
      'hrsh7th/nvim-cmp',
      config = function()
        require('plugins.cmp_conf')
      end
    },
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
  }

  -- git signs in the gutter
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup({keymaps = {}})
    end
  }

  -- statusline
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  config = function()
    require('plugins.lualine_conf')
  end
}

  --improves on matchit, adding a lot of text objects and some logic.
  use 'andymass/vim-matchup'

  -- provide a shortcut for sorting text in a motion/textobj
  use 'christoomey/vim-sort-motion'

  -- the theme
  use { 'dracula/vim', as = 'dracula' }

  -- pretty list
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config=function()
      require('plugins.trouble_conf')
    end
  }

  -- provide text objects for comments
  use 'glts/vim-textobj-comment'

  -- provide text objects for indents
  use {
    'kana/vim-textobj-indent',
    requires = {'kana/vim-textobj-user'}
  }

  -- provide text objects for lines
  use {
    'kana/vim-textobj-line',
    requires = {'kana/vim-textobj-user'}
  }

  -- dashboard
  use {
    'glepnir/dashboard-nvim',
    config = function()
      require('plugins.dashboard_conf')
    end
  }

  -- smooth scrolling operations
  use {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup()
    end
  }

  -- autogenerate tagfiles
  use 'ludovicchabant/vim-gutentags'

  -- file tree browser window
  use {
    'ms-jpq/chadtree',
    branch = 'chad',
    run = 'python3 -m chadtree deps',
    config = function()
      require('plugins.chadtree_conf')
    end
  }

  -- autoswitch between relative and absolute numbers based on window status
  use {
    'myusuf3/numbers.vim',
    config = function()
      require('plugins.numbers_conf')
    end
  }

  -- LSP config
  use 'neovim/nvim-lspconfig'

  -- LSP Installer
  use 'williamboman/nvim-lsp-installer'

  -- Floating terminal window
  use {
    'numToStr/FTerm.nvim',
    config = function()
      require('plugins.FTerm_conf')
    end
  }

  -- fuzzy finder over lists
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'} },
    config = function()
      require('plugins.telescope_conf')
    end
  }

  -- native FZF impl for Telescope
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- LSP signature completion support
  use {
    'ray-x/lsp_signature.nvim',
    config = function()
      require "lsp_signature".setup()
    end
  }

  -- Add support for a wide range of filetypes
  use 'sheerun/vim-polyglot'

  -- Allow you to edit files directly from the quickfix results
  use 'stefandtw/quickfix-reflector.vim'

  -- Provide operators for commenting code.
  use 'tpope/vim-commentary'

  -- Automatically add 'end' statements as appropriate
  use 'tpope/vim-endwise'

  -- Git plugin
  use {
    'tpope/vim-fugitive',
    requires = { {'shumphrey/fugitive-gitlab.vim'} },
    config = function()
      require('plugins.fugitive_conf')
    end
  }

  -- Allow custom commands to be repeated
  use 'tpope/vim-repeat'

  -- Enables :GBrowse, autocomplete, etc. to pull from GitHub.
  use 'tpope/vim-rhubarb'

  -- Enables operators for manipulating surrounding punctuations
  use 'tpope/vim-surround'

  -- Adds a 'quick highlight' functionality to allow you to navigate quickly
  use {
    'unblevable/quick-scope',
    config = function()
      require('plugins.quick-scope_conf')
    end
  }

  -- try to hide ansi escape codes
  use 'vim-scripts/AnsiEsc.vim'

  -- allow for a broader range of text objects
  use 'wellle/targets.vim'

  -- automatically show pairs
  use {
    'windwp/nvim-autopairs',
    after = {'nvim-treesitter', 'nvim-cmp'},
    config = "require('plugins.autopairs_conf')"
  }

  -- show indentation guidelines
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      vim.g.indentLine_fileTypeExclude = vim.g.tm_special_buffers
      require("indent_blankline").setup {
        char = "|"
      }
    end
  }

  -- highlight hex codes
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require('colorizer').setup()
    end
  }

  -- use rufo
  use {
    'ruby-formatter/rufo-vim',
    config = function()
      vim.g.rufo_auto_formatting = 1
    end
  }

  -- smart date incrementation
  use 'tpope/vim-speeddating'

  -- show icons in LSP hints
  use 'onsails/lspkind-nvim'

  -- build system
  use {
    'pianocomposer321/yabs.nvim',
    config = function()
      require('plugins.yabs_conf')
    end
  }

  use {
    'tmux-plugins/vim-tmux'
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
