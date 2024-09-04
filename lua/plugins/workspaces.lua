return {
  'natecraddock/workspaces.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('workspaces').setup({
      cd_type = "local",
      hooks = {
        open = { "Telescope find_files" },
      }
    })

    require('telescope').load_extension("workspaces")

    vim.keymap.set('n', '<leader>fw', '<cmd>WorkspacesOpen<CR>', { desc = '[F]ind [W]orkspace' })
  end
}
