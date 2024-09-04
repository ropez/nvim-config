return {
  'mfussenegger/nvim-dap',

  config = function()
    local dap = require("dap")

    set_cond_breakpoint = function()
      dap.set_breakpoint(vim.ui.input('Breakpoint condition: '))
    end
    set_log_point = function()
      dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
    end

    vim.keymap.set('n', '<Leader>d<space>', dap.continue, { desc = "Start/Continue" })
    vim.keymap.set('n', '<Leader>da', dap.continue, { desc = "Start/Continue" })
    vim.keymap.set('n', '<Leader>dq', dap.disconnect, { desc = "Disconnect" })
    vim.keymap.set('n', '<Leader>dn', dap.step_over, { desc = "Step Over" })
    vim.keymap.set('n', '<Leader>d<cr>', dap.step_over, { desc = "Step Over" })
    vim.keymap.set('n', '<Leader>di', dap.step_into, { desc = "Step Into" })
    vim.keymap.set('n', '<Leader>do', dap.step_out, { desc = "Step Out" })
    vim.keymap.set('n', '<Leader>dd', dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set('n', '<Leader>dc', set_cond_breakpoint, { desc = "Conditional Breakpoint" })
    vim.keymap.set('n', '<Leader>dp', set_log_point, { desc = "Log Point" })
    vim.keymap.set('n', '<Leader>dr', dap.repl.open, { desc = "Open REPL" })
    vim.keymap.set('n', '<Leader>dl', dap.run_last, { desc = "Run Last" })
  end
}
