local sumneko_lua = {}

sumneko_lua.setup_opts = {
  settings = {
    Lua = {
      diagnostics = {
        -- set hs, vim, and use to be recognized globals
        -- vim and use for vim lua, hs for hammerspoon
        globals = { 'hs', 'vim', 'use' }
      }
    }
  }
}

return sumneko_lua
