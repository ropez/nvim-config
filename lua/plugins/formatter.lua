return {
  'seblj/nvim-formatter',

  opts = {
    filetype = {
      rust = 'rustfmt --edition 2021',
      html = 'prettierd .html',
      typescript = 'prettierd .ts',
      javascipt = 'prettierd .js',
      vue = 'prettierd .vue',
      svelte = 'prettier --write --stdin-filepath .svelte',
      graphql = 'prettierd .gql',
      cs = 'dotnet csharpier',
      dart = 'dart format --line-length=100 -o show',
      terraform = 'terraform fmt -'
    }
  },

  init = function(opts)
    vim.keymap.set('n', '<C-j>', ':Format<cr>')
  end
}
