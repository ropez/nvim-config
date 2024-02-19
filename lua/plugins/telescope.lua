return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<esc>"] = "close",
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    })

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

    vim.keymap.set('n', 'gd', builtin.lsp_definitions)
    vim.keymap.set('n', 'gr', builtin.lsp_references)
    vim.keymap.set('n', 'gi', builtin.lsp_implementations)
  end
}
