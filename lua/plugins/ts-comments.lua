-- Sane defaults for commenting
return {
  "folke/ts-comments.nvim",
  event = "VeryLazy",
  opts = {
    lang = {
      dart = "// %s", -- FIXME Doesn't work without treesitter dart
    }
  },
}
