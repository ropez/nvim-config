return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    columns = {
      'icon',
    },
    float = {
      max_width = 80,
      padding = 4,
    },
    keymaps = {
      ['<esc>'] = 'actions.close',
    },
  },
  init = function()
    local oil = require('oil')
    vim.keymap.set('n', '<leader>o', oil.open_float, { desc = "Open file explorer" })
  end
}
