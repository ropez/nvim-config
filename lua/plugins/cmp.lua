return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'neovim/nvim-lspconfig',
    'hrsh7th/vim-vsnip',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    local cmp = require('cmp')

    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- Accept currently selected item. Set `select` to `false` to
        -- only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
      }),

      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'codeium' },
      }, {
        { name = 'buffer' },
      })
    })
  end
}
