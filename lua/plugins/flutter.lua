return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require("flutter-tools").setup {
      closing_tags = { enabled = false },
      lsp = {
        capabilities = function(config)
          config.definitionProvider = true
          return config
        end,
        on_attach = function()
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
        end,
      }
    }
  end
}
