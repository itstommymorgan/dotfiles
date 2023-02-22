-- This file contains configuration for plugins that provide any kind of
-- interface/display specific to coding (or working in source control).

return {
  -- show where we are in the code
  {
    'SmiteshP/nvim-gps',
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" }
  },

  -- git signs in the gutter
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = true,
    opts = {keymaps = {}},
  },

  -- Floating terminal windows
  'numToStr/FTerm.nvim',

  -- Git plugin
  {
    'tpope/vim-fugitive',
    dependencies = { 'shumphrey/fugitive-gitlab.vim' },
  },

  -- Enables :GBrowse, autocomplete, etc. to pull from GitHub.
  'tpope/vim-rhubarb',

  -- automatically show pairs
  {
    'windwp/nvim-autopairs',
    after = {'nvim-treesitter', 'nvim-cmp'},
    config = function()
      require('nvim-autopairs').setup()
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
    end,
  },

  -- show indentation guidelines
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      vim.g.indentLine_fileTypeExclude = vim.g.tm_special_buffers
      require("indent_blankline").setup {
        char = "|"
      }
    end,
  },

  -- highlight hex codes
  {
    "norcalli/nvim-colorizer.lua",
    config = true
  },

  -- pretty list
  {
    'folke/trouble.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = true,
  },

  -- Add support for a wide range of filetypes
  'sheerun/vim-polyglot',

  -- Allow you to edit files directly from the quickfix results
  'stefandtw/quickfix-reflector.vim',

}
