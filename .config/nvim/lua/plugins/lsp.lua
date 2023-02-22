-- This file contains configuration flazyor all lsp-related plugins.

return {
  -- LSP config
  'neovim/nvim-lspconfig',

  -- LSP Installer
  'williamboman/nvim-lsp-installer',

  -- LSP signature completion support
  {
    'ray-x/lsp_signature.nvim',
    config = true,
  },
}
