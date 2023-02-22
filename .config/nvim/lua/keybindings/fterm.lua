-- Leader-t toggles the FTerm if we're in normal mode
config.nmap('<Leader>t', ":lua require('FTerm').toggle()<CR>")

-- <LocalLeader><Esc> to close the FTerm
vim.cmd [[augroup terminalleader
  au Filetype FTerm tnoremap <buffer> <silent><LocalLeader><Esc> <C-\><C-N>:lua require('FTerm').toggle()<CR>
  augroup END]]
