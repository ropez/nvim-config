return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require('lspconfig')

    lspconfig.rust_analyzer.setup {}
    lspconfig.tsserver.setup {}
    lspconfig.volar.setup {} -- TODO Install server

    vim.diagnostic.config({
      virtual_text = false,
    })

    vim.keymap.set('n', 'K', vim.lsp.buf.hover)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
  end
}
