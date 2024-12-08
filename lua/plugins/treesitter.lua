return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',

  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript',
        'typescript', 'vimdoc', 'vim', 'bash', 'vue', 'css', 'scss', 'graphql',
        'svelte', 'dart',
      },
      highlight = { enable = true },
      indent = {
        enable = true,
        -- Disabling because it was causing a few seconds of delay when creating
        -- a new line in the file.
        -- https://github.com/UserNobody14/tree-sitter-dart/issues/48
        -- https://github.com/UserNobody14/tree-sitter-dart/issues/46
        -- https://github.com/nvim-treesitter/nvim-treesitter/issues/4945
        disable = { "dart", },
      },
      textobjects = {
        select = {
          enable = true,
          -- Disabling because it was causing a few seconds of delay when creating
          -- a new line in the file.
          -- https://github.com/UserNobody14/tree-sitter-dart/issues/48
          -- https://github.com/UserNobody14/tree-sitter-dart/issues/46
          -- https://github.com/nvim-treesitter/nvim-treesitter/issues/4945
          disable = { "dart", },
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
            [']a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
            ['[a'] = '@parameter.inner',
          },
        },
      },
    })

    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.opt.foldlevelstart = 99
  end,
}
