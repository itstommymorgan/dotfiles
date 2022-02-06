-- This file will always be first in my nvim config, so anything that needs to
-- be done before ANYTHING else (or otherwise really basic setup) goes here.

config = require('config')

-- declare a variable for all the filetypes we want to exclude from various
-- plugins
vim.g.tm_special_buffers = {'CHADTree', 'fzf', 'FTerm', 'dashboard'}

-- use <SPACE> for mapleader
config.nmap('<Space>', '')
vim.g.mapleader = ' '

-- For some modes (e.g. terminal) <Space> won't work as a leader, so let's
-- define <C-Space> to be our localleader
vim.g.maplocalleader = 'jk'

-- Please don't abandon my poor buffers
config.option('hidden', true)

-- Don't wait forever for other keystrokes
config.option('timeoutlen', 1000)
config.option('ttimeoutlen', 0)

-- see help shortmess (different from hotmess, I guesss)
config.option('shortmess', 'atTIq')


-- enable the mouse (I know, I'm a terrible person)
config.option('mouse', 'a')

-- smart case sensitivity in search
config.option('ignorecase', true)
config.option('smartcase', true)

-- temp/undo files for fun and profit
local backupdirs = '~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp'
config.option('backupdir', backupdirs)
config.option('directory', backupdirs)
config.option('undodir', backupdirs)
config.option('undofile', true)

-- stop annoying me when I open a file in two different vim sessions.
-- 'e' means Edit Anyway - help v:swapchoice for other options.
vim.cmd [[augroup SimultaneousEdits
  autocmd!
  autocmd SwapExists * :let v:swapchoice = 'e'
augroup END]]
