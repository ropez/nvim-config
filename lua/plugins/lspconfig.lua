return {
  "neovim/nvim-lspconfig",
  config = function()
    on_attach = function()
      vim.keymap.set('n', '<leader>ji', vim.lsp.buf.hover, { desc = "Show information" })
      vim.keymap.set('n', '<leader>jh', vim.lsp.buf.signature_help, { desc = "Signature help" })
      vim.keymap.set('n', '<leader>jr', vim.lsp.buf.rename, { desc = "Rename" })
      vim.keymap.set('n', '<a-cr>', vim.lsp.buf.code_action)
      vim.keymap.set('v', '<a-cr>', vim.lsp.buf.code_action)


      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
      vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
      vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
    end

    local lspconfig = require('lspconfig')

    lspconfig.pyright.setup {}
    lspconfig.rust_analyzer.setup {
      experimental = {
        serverStatusNotification = true
      }
    }
    lspconfig.tsserver.setup {}
    lspconfig.omnisharp.setup {
      cmd = { 'omnisharp' },
    }
    lspconfig.volar.setup {}
    lspconfig.biome.setup {}
    lspconfig.svelte.setup {}

    vim.diagnostic.config({
      virtual_text = false,
    })

    -- FIXME: Is there a global default setup?
    on_attach()
  end
}
