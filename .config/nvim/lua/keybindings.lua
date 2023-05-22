-- <Leader><Leader> is a shortcut for commands
config.nmap('<Leader><Leader>', ':')

-- <Leader>w writes the current buffer to disk
config.map('<Leader>w', ':w!<CR>')

-- <Leader>q quits the current window
config.map('<Leader>q', ':q!<CR>')

-- <Leader>Q quits all windows
config.map('<Leader>Q', ':qa!<CR>')

-- <Leader>h/j/k/l navigates windows
-- <Leader>H/J/K/L moves windows
local keys = {'h', 'j', 'k', 'l', 'H', 'J', 'K', 'L'}
for count = 1, #keys do 
  key = keys[count]
  config.map('<Leader>' .. key, '<C-W>' .. key)
end

-- use <Leader>s for vertical split, <Leader>S for horizontal split
config.map('<Leader>s', ':vs<CR><C-W>l')
config.map('<Leader>S', ':sp<CR><C-W>j')

-- use <Leader>b to switch back to the last buffer you were looking at.
config.map('<Leader>b', '<C-^>')

-- reload vim config with <Leader>V
config.map('<Leader>V', ':so ~/.config/nvim/init.lua<CR>')

-- make Y behave like D, A, I, etc.
config.map('Y', 'y$')

-- make Q repeat the last recorded macro
config.map('Q', '@@')

-- make H/J/K/L work like super versions of h/j/k/l
config.map('H', '^', { noremap = false })
config.map('J', '<C-f>', { noremap = false })
config.map('K', '<C-b>', { noremap = false })
config.map('L', '$', { noremap = false })

-- use <Leader>i to toggle display of hidden characters
config.map('<Leader>i', ':set list!<CR>')

-- Hit escape twice to clear highlights (normal only)
config.nmap('<Esc><Esc>', ':nohls<CR>', { silent = true })
config.nmap('<C-@><C-@>', ':nohls<CR>', { silent = true })
config.nmap('<C-Space><C-Space>', ':nohls<CR>', { silent = true })

--  keep search results in the center of the screen
local search_keys = {'n', 'N', '*', '#', 'g*', 'g#'}
for count = 1, #search_keys do
  key = search_keys[count]
  config.nmap(key, key .. 'zz', { silent = true, noremap = false })
end

require 'keybindings.dashboard'
require 'keybindings.fterm'
require 'keybindings.fugitive'
require 'keybindings.telescope'
require 'keybindings.trouble'
