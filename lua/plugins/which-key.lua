return {
  "folke/which-key.nvim",
  commit = "68e37e1", -- https://github.com/folke/which-key.nvim/issues/898
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 200
  end,
  opts = {
    preset = 'helix',
    icons = {
      mappings = false,
    },
  },
}
