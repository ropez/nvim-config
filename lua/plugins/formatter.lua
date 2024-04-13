return {
  'seblj/nvim-formatter',

  opts = {
    filetype = {
      rust = 'rustfmt --edition 2021',
      typescript = 'prettierd .ts',
      javascipt = 'prettierd .js',
      vue = 'prettierd .vue',
      svelte = 'prettier --write --stdin-filepath .svelte',
      graphql = 'prettierd .gql',
      cs = 'dotnet csharpier',
    }
  },

  init = function(opts)
    vim.keymap.set('n', '<C-j>', ':FormatWrite<cr>')
  end
}
