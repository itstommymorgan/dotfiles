-- This file contains configuration for plugins that impact the general UI of
-- editing in neovim (i.e. not coding-specific).

return {
  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = true,
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {}
    },
  },

  -- the theme
  { 'dracula/vim', name = 'dracula' },

  -- dashboard
  {
    'glepnir/dashboard-nvim',
    config = function()
      vim.g.dashboard_default_executive = 'telescope'
      require('keybindings.dashboard')
    end,
  },

  -- smooth scrolling operations
  {
    'karb94/neoscroll.nvim',
    config = true,
  },

  -- file tree browser window
  {
    'ms-jpq/chadtree',
    branch = 'chad',
    build = 'python3 -m chadtree deps',
    config = function()
      config.nmap('-', ':silent CHADopen<cr>')

      local ignore_list = {'.DS_Store', '.directory', 'thumbs.db', '.git', 'tags'}

      vim.g.chadtree_settings = {
        ignore = {
          name_exact = ignore_list
        },
        keymap = {
          quit = {'-'},
          bigger = {'>'},
          smaller = {'<'}
        },
        theme = {
          icon_colour_set = 'github'
        }
      }
    end,
  },

  -- autoswitch between relative and absolute numbers based on window status
  {
    'myusuf3/numbers.vim',
    config = function()
      vim.g.numbers_exclude = vim.g.tm_special_buffers
    end,
  },

  -- Floating terminal window
  {
    'numToStr/FTerm.nvim',
    config = function()
      require('keybindings.fterm')
    end,
  },

  -- fuzzy finder over lists
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      require('keybindings.telescope')
    end,
  },

  -- try to hide ansi escape codes
  'vim-scripts/AnsiEsc.vim',
}
