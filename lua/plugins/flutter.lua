local function set_flutter_pid()
  local dap_utils = require('dap.utils')
  vim.g.flutter_pid = dap_utils.pick_process({
    filter = ".*flutter.*run.*"
  })
end

local function flutter_reload()
  if vim.g.flutter_pid == nil then
    set_flutter_pid()
  end

  os.execute("kill -USR1 " .. vim.g.flutter_pid)
end

local function flutter_restart()
  if vim.g.flutter_pid == nil then
    set_flutter_pid()
  end

  os.execute("kill -USR2 " .. vim.g.flutter_pid)
end

return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  -- enabled = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require("flutter-tools").setup {
      flutter_lookup_cmd = "mise where flutter",
      closing_tags = { enabled = false },
      lsp = {
        settings = {
          analysisExcludedFolders = {"/home/robin/.asdf"},
        },
        capabilities = function(config)
          config.definitionProvider = true
          return config
        end,
        on_attach = function()
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
        end,
      },
      debugger = {
        enabled = true,
        exception_breakpoints = {},
        register_configurations = function(paths)
          local dap = require("dap")
          for _, conf in ipairs(dap.configurations.dart) do
            conf.toolArgs = {
              -- "--device-user=0",
              "--dart-define-from-file=.env",
            }
          end
        end,
      },
    }

    -- vim.keymap.set('n', ',f', set_flutter_pid, { desc = "Select flutter process" })
    -- vim.keymap.set('n', ',r', flutter_restart, { desc = "Restart flutter" })
    -- vim.keymap.set('n', ',w', flutter_reload, { desc = "Reload flutter" })
  end
}
