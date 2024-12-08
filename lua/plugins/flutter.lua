function set_flutter_pid()
  local dap_utils = require('dap.utils')
  vim.g.flutter_pid = dap_utils.pick_process({
    filter = ".*flutter.*"
  })
end

function flutter_reload()
  if vim.g.flutter_pid == nil then
    set_flutter_pid()
  end

  os.execute("kill -USR1 " .. vim.g.flutter_pid)
end

function flutter_restart()
  if vim.g.flutter_pid == nil then
    set_flutter_pid()
  end

  os.execute("kill -USR2 " .. vim.g.flutter_pid)
end

return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require("flutter-tools").setup {
      closing_tags = { enabled = false },
      lsp = {
        capabilities = function(config)
          config.definitionProvider = true
          return config
        end,
        on_attach = function()
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
        end,
      }
    }

    vim.keymap.set('n', ',f', set_flutter_pid, { desc = "Select flutter process" })
    vim.keymap.set('n', ',r', flutter_restart, { desc = "Restart flutter" })
    vim.keymap.set('n', ',w', flutter_reload, { desc = "Reload flutter" })
  end
}
