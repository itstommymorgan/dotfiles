require('config')

config.option('background', 'dark')
vim.cmd('silent! colorscheme dracula')

-- show matching brackets/etc
config.option('showmatch', true)
-- show filename in title string
config.option('title', true)

-- tmux fix (don't ask me, ask stack overflow)
vim.cmd([[
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
]])

-- use gui termcolors (for CHADTree, mostly)
config.option('termguicolors', true)

-- always show at least 7 lines around the cursor
config.option('scrolloff', 7)

-- show whitespace by default
config.option('list', true)
local whitespacechars = 'tab:▸ ,trail:•,precedes:«,extends:»'
config.option('listchars', whitespacechars)
