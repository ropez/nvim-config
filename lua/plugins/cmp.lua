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

      preselect = cmp.PreselectMode.None,

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
        -- { name = 'codeium' },
      }, {
        { name = 'buffer' },
      })
    })

    -- vim.api.nvim_set_keymap('i', '<Tab>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"', { expr = true, noremap = true })
    -- vim.api.nvim_set_keymap('s', '<Tab>', 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"', { expr = true, noremap = true })
    -- vim.api.nvim_set_keymap('i', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', { expr = true, noremap = true })
    -- vim.api.nvim_set_keymap('s', '<S-Tab>', 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', { expr = true, noremap = true })

    local trigger_codeium = function()
      cmp.complete {
        config = {
          sources = {
            { name = 'codeium' },
          }
        }
      }
    end

    -- TODO Maybe <C-space> can toggle between different modes?
    vim.keymap.set('i', '<C-M-Space>', trigger_codeium, { desc = 'trigger codeium completion', noremap = true })
    vim.keymap.set('i', '<M-,>', trigger_copilot, { desc = 'trigger copilot completion', noremap = true })

    vim.api.nvim_set_keymap('i', '<C-e>', '<Plug>(vsnip-jump-next)', { noremap = true })
    vim.api.nvim_set_keymap('s', '<C-e>', '<Plug>(vsnip-jump-next)', { noremap = true })
    vim.api.nvim_set_keymap('i', '<C-y>', '<Plug>(vsnip-jump-prev)', { noremap = true })
    vim.api.nvim_set_keymap('s', '<C-y>', '<Plug>(vsnip-jump-prev)', { noremap = true })
  end
}
