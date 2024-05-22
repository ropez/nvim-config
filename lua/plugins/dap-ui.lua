return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    'nvim-telescope/telescope.nvim',
  },

  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- FIXME: Can we import configs from a path prefix?

    dap.adapters.coreclr = {
      type = 'executable',
      command = 'netcoredbg',
      args = {'--interpreter=vscode'}
    }

    dap.adapters.lldb = {
      type = 'executable',
      command = '/usr/bin/lldb-vscode', -- must be absolute path
      name = 'lldb'
    }

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    -- dap.configurations.cs = {
    --   {
    --     type = "coreclr",
    --     name = "attach - netcoredbg",
    --     request = "attach",
    --     pid = require('dap.utils').pick_process,
    --     args = {},
    --   },
    -- }

    dap.configurations.rust = {
      {
        type = 'lldb',
        name = 'attach - lldb',
        request = "attach",
        pid = require('dap.utils').pick_process,
        args = {},
      },
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        env = {
          DOTNET_ENVIRONMENT = 'Development',
        },
        program = function()
          return coroutine.create(function(coro)
            local opts = {}
            pickers
              .new(opts, {
                prompt_title = "Select DLL",
                finder = finders.new_oneshot_job({
                  "find",
                  "-ipath", '*/bin/debug/*',
                  "-iname", '*.dll',
                }, {}),
                sorter = conf.generic_sorter(opts),
                attach_mappings = function(buffer_number)
                  actions.select_default:replace(function()
                    actions.close(buffer_number)
                    coroutine.resume(coro, action_state.get_selected_entry()[1])
                  end)
                  return true
                end,
              })
              :find()
          end)
        end,
      },
    }

    -- dap.configurations.rust = {
    --   {
    --     name = 'Launch',
    --     type = 'lldb',
    --     request = 'launch',
    --     program = function()
    --       return coroutine.create(function(coro)
    --         local opts = {}
    --         pickers
    --           .new(opts, {
    --             prompt_title = "Select DLL",
    --             finder = finders.new_oneshot_job({
    --               "find",
    --               "-ipath", '*/target/*',
    --               "-executable"
    --             }, {}),
    --             sorter = conf.generic_sorter(opts),
    --             attach_mappings = function(buffer_number)
    --               actions.select_default:replace(function()
    --                 actions.close(buffer_number)
    --                 coroutine.resume(coro, action_state.get_selected_entry()[1])
    --               end)
    --               return true
    --             end,
    --           })
    --           :find()
    --       end)
    --     end,
    --     cwd = '${workspaceFolder}',
    --     stopOnEntry = false,
    --     args = {},
    --   },
    -- }
  end
}
