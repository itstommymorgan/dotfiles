local signs = { Error = " 🞮", Warn = " ▲", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- UI just like `:LspInfo` to show which capabilities each attached server has
vim.api.nvim_command("command! LspCapabilities lua require'lsp/capabilities'()")

require('lsp/installer')

vim.api.nvim_command("autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_seq_sync()")
