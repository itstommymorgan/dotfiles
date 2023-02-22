-- use <Leader>g as the start of all our chords
local function yabs_bind(key, action)
  key = '<Leader>y' .. key
  config.map(key, action)
end

-- <chord>a to run all specs
yabs_bind('a', ':lua require("yabs"):run_task("run_specs")<CR>')

-- <chord>s to run current file
yabs_bind('s', ':lua require("yabs"):run_task("run_spec_file")<CR>')

-- <chord>S to run current spec
yabs_bind('S', ':lua require("yabs"):run_task("run_spec")<CR>')

-- <chord>t to toggle yabsterm
yabs_bind('t', ':lua __yabsterm:toggle()<CR>')

-- <LocalLeader><Esc> to close the yabsterm
vim.cmd [[augroup yabsterminalleader
  au Filetype FTerm-yabs tnoremap <buffer> <silent><LocalLeader><Esc> <C-\><C-N>:lua __yabsterm:toggle()<CR>
  augroup END]]
