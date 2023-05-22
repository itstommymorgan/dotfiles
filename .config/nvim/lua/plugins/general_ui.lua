-- This file contains configuration for all plugins related to general (i.e. not
-- code-specific) editing in neovim.

return {
  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
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

  --improves on matchit, adding a lot of text objects and some logic.
  'andymass/vim-matchup',

   -- the theme
  { 'dracula/vim', as = 'dracula' },

   -- pretty list
  {
    'folke/trouble.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = true
  },

  -- dashboard
  'glepnir/dashboard-nvim',

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
      -- use - to toggle the tree
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
    end
  },

  -- autoswitch between relative and absolute numbers based on window status
  {
    'myusuf3/numbers.vim',
    config = function()
      vim.g.numbers_exclude = vim.g.tm_special_buffers
    end
  },

  -- fuzzy finder over lists
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make'}
    },
    config = function()
      local actions = require("telescope.actions")
      local trouble = require("trouble.providers.telescope")

      require('telescope').setup({
          defaults = {
            mappings = {
              i = {
                ["<c-t>"] = trouble.open_with_trouble,
                ["<esc>"] = actions.close
              },
              n = {
                ["<c-t>"] = trouble.open_with_trouble
              }
            },
            vimgrep_arguments = {
              'rg', '--hidden', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'
            }
          },
          pickers = {
            find_files = {
              hidden = true
            }
          }
        })

      require('telescope').load_extension('fzf')
    end
  },

  -- native FZF impl for Telescope
  {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

   -- try to hide ansi escape codes
  'powerman/vim-plugin-AnsiEsc',
}
