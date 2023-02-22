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

config.nmap('<Leader>f<Leader>', '<cmd>Telescope grep_string<cr>')
config.nmap('<Leader>fb', '<cmd>Telescope buffers theme=ivy<cr>')
config.nmap('<Leader>ff', '<cmd>Telescope find_files theme=ivy<cr>')
config.nmap('<Leader>fg', '<cmd>Telescope live_grep<cr>')
config.nmap('<Leader>fh', '<cmd>Telescope help_tags<cr>')
config.nmap('<Leader>fm', '<cmd>Telescope keymaps<cr>')
config.nmap('<Leader>ft', '<cmd>Telescope tags<cr>')
