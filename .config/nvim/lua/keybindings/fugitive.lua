_G.__gitterm = require('FTerm'):new({ft='FTerm-git'})

-- use <Leader>g as the start of all our chords
local function fugitive_bind(key, action)
  key = '<Leader>g' .. key
  config.map(key, action)
end

-- <chord>b for blame
fugitive_bind('b', ':Git blame<CR>')

-- <chord>d for diff
fugitive_bind('d', ':Gdiff<CR>')

-- <chord>l for log
fugitive_bind('l', ':Git log<CR>')

-- <chord>o for open (browse)
fugitive_bind('o', ':GBrowse<CR>')

-- <chord>p for push
fugitive_bind('p', ':lua __gitterm:run("gp")<CR>')

-- <chord>s for status
fugitive_bind('s', ':Git<CR>')

-- <chord>t to open the git terminal
fugitive_bind('t', ':lua __gitterm:toggle()<CR>')

-- <chord>u for git-up
fugitive_bind('u', ':lua __gitterm:run("git-smart-sync")<CR>')

-- <LocalLeader><Esc> to close the gitterm
vim.cmd [[augroup gitterminalleader
  au Filetype FTerm-git tnoremap <buffer> <silent><LocalLeader><Esc> <C-\><C-N>:lua __gitterm:toggle()<CR>
  augroup END]]
