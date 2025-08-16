return {
  'seblj/nvim-formatter',

  opts = {
    filetype = {
      rust = 'rustfmt --edition 2021',
      -- rust = 'leptosfmt -rs',
      go = 'gofmt',
      bicep = 'bicep-linux-x64 format - --stdout',
      html = 'prettierd .html',
      typescript = 'prettierd .ts',
      javascipt = 'prettierd .js',
      vue = 'prettierd .vue',
      svelte = 'prettierd .svelte',
      graphql = 'prettierd .gql',
      cs = 'dotnet csharpier',
      dart = 'dart format --line-length=120 -o show',
      terraform = 'tofu fmt -',
      json = 'jq',
    }
  },

  init = function(opts)
    vim.keymap.set('n', '<C-Space>', ':Format<cr>')
  end
}
