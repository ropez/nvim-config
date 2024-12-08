return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd [[silent! colorscheme catppuccin-mocha]]
  end,
}
