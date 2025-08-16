return {
  'tpope/vim-repeat',
  'tpope/vim-sleuth',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'tpope/vim-fugitive',
  'tpope/vim-abolish',

  -- LSP messages in bottom-right corner
  { "j-hui/fidget.nvim", opts = { notification = { override_vim_notify = true } } },

  -- Additional themes
  { 'projekt0n/github-nvim-theme' },

  {
    'ropez/declarative.nvim',

    enabled = true,
    lazy = false,
    priority = -1000,
  },
}
