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
