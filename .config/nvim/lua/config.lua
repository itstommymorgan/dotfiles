local config = { }

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

function config.option(key, value)
  scopes['o'][key] = value
end

function config.boption(key, value)
  scopes['b'][key] = value
end

function config.woption(key, value)
  scopes['w'][key] = value
end

function config.map(lhs, rhs, opts)
  config.bind_map('', lhs, rhs, opts)
end

function config.nmap(lhs, rhs, opts)
  config.bind_map('n', lhs, rhs, opts)
end

function config.cbuf_map(lhs, rhs, opts)
  config.buf_map(0, lhs, rhs, opts)
end

function config.buf_map(bufnr, lhs, rhs, opts)
  config.buf_bind_map(bufnr, '', lhs, rhs, opts)
end

function config.cbuf_nmap(lhs, rhs, opts)
  config.buf_nmap(0, lhs, rhs, opts)
end

function config.buf_nmap(bufnr, lhs, rhs, opts)
  config.buf_bind_map(bufnr, 'n', lhs, rhs, opts)
end

function config.buf_bind_map(bufnr, mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

function config.bind_map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return config
