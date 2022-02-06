local sumneko_lua = {}

sumneko_lua.setup_opts = {
  settings = {
    Lua = {
      diagnostics = {
        -- set vim and use to be recognized globals
        globals = { 'vim', 'use' }
      }
    }
  }
}

return sumneko_lua
