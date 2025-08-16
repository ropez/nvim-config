return {
  -- TMUX integration
  'christoomey/vim-tmux-navigator',

  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },

  keys = {
    { "<A-h>", "<cmd>TmuxNavigateLeft<cr>" },
    { "<A-j>", "<cmd>TmuxNavigateDown<cr>" },
    { "<A-k>", "<cmd>TmuxNavigateUp<cr>" },
    { "<A-l>", "<cmd>TmuxNavigateRight<cr>" },
    { "<A-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
  },

  -- keys = {
  --   { "<m-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
  --   { "<m-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
  --   { "<m-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
  --   { "<m-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
  --   { "<m-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  -- },
}
