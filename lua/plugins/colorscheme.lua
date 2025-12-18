return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    vim.api.nvim_command([[
        augroup ChangeBackgroudColour
            autocmd colorscheme * :hi normal guibg=#0A0721

            " Inactive window
            autocmd colorscheme * :hi NormalNC guibg=#0A0721

            " Status line
            autocmd colorscheme * :hi StatusLine guibg=#131033
            autocmd colorscheme * :hi StatusLineNC guibg=#131033

            " Lua line
            autocmd colorscheme * :hi LineNr guibg=#131033

        augroup END
    ]])
    -- vim.o.termguicolors = true
    vim.cmd [[silent! colorscheme catppuccin-mocha]]
  end,
}
