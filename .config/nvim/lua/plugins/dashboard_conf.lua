vim.g.dashboard_default_executive = 'telescope'

vim.g.dashboard_custom_shortcut = {
  last_session = 'l',
  find_history = 'h',
  find_file = 'f',
  new_file = 'n',
  change_colorscheme = 'c',
  find_word = 'w',
  book_marks = 'b'
}

config.dashboard_keybindings_func = function()
  config.cbuf_nmap('l', ':<C-u>SessionLoad<CR>')
  config.cbuf_nmap('h', ':DashboardFindHistory<CR>', {silent = true })
  config.cbuf_nmap('f', ':DashboardFindFile<CR>', { silent = true })
  config.cbuf_nmap('c', ':DashboardChangeColorscheme<CR>', { silent = true })
  config.cbuf_nmap('b', ':DashboardJumpMark<CR>', { silent = true })
  config.cbuf_nmap('w', ':DashboardFindWord<CR>', { silent = true })
  config.cbuf_nmap('n', ':DashboardNewFile<CR>', { silent = true })
end

vim.cmd [[augroup DashboardKeybindings
  autocmd!
  autocmd FileType dashboard lua config.dashboard_keybindings_func()
augroup END]]

-- Global keybindings for saving/loading the session
config.nmap('<Leader>xss', ':<C-u>SessionSave<CR>', { noremap = false })
config.nmap('<Leader>xsl', ':<C-u>SessionLoad<CR>', { noremap = false })
