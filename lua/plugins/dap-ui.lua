return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mxsdev/nvim-dap-vscode-js",
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

    dap.adapters.coreclr = function(cb, config)
      if config.processId == nil then
        return
      end

      cb({
        type = 'executable',
        command = 'netcoredbg',
        args = {'--interpreter=vscode'}
      })
    end

    dap.adapters.lldb = {
      type = 'executable',
      command = '/usr/bin/lldb-vscode', -- must be absolute path
      name = 'lldb'
    }

    local dapJs = require("dap-vscode-js")

    dapJs.setup({
      debugger_path = "/home/robin/.local/share/vscode-js-debug",
      adapters = { 'pwa-node', 'pwa-chrome', 'node-terminal' },
    })

    -- dap.adapters.node = {
    --   type = 'server',
    --   host = 'localhost',
    --   port = '45123',
    --   executable = {
    --     command = 'node',
    --     args = {'/home/robin/.local/share/js-debug/src/dapDebugServer.js', "45123"},
    --   }
    -- }

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local dap_utils = require('dap.utils')

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "attach - netcoredbg",
        request = "attach",
        processId = function()
          return dap_utils.pick_process({
            filter = ".*/Debug/.*"
          })
        end,
        args = {},
      },
    }

    dap.configurations.rust = {
      {
        type = 'lldb',
        name = 'attach - lldb',
        request = "attach",
        pid = dap_utils.pick_process,
        args = {},
      },
    }

    for _, lang in ipairs({ 'typescript', 'javascript' }) do
      dap.configurations[lang] = {
        {
          request = 'launch',
          type = 'pwa-node',
          name = "Launch file",
          port = '45123',
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          -- For this to work you need to make sure the node process is started with the `--inspect` flag.
          request = 'attach',
          type = 'pwa-node',
          name = 'Attach',
          processId = function()
            return dap_utils.pick_process({
              filter = ".*--inspect.*"
            })
          end,
          cwd = "${workspaceFolder}",
        },
      }
    end

    -- dap.configurations.cs = {
    --   {
    --     type = "coreclr",
    --     name = "launch - netcoredbg",
    --     request = "launch",
    --     env = {
    --       DOTNET_ENVIRONMENT = 'Development',
    --     },
    --     program = function()
    --       return coroutine.create(function(coro)
    --         local opts = {}
    --         pickers
    --           .new(opts, {
    --             prompt_title = "Select DLL",
    --             finder = finders.new_oneshot_job({
    --               "find",
    --               "-ipath", '*/bin/debug/*',
    --               "-iname", '*.dll',
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
    --   },
    -- }

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
    --

    vim.keymap.set('n', '<Leader>du', dapui.toggle, { desc = "Toggle Debug UI" })
  end
}
