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

    vim.keymap.set('n', '<F5>', dap.continue, { desc = "Start/Continue" })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = "Step Over" })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = "Step Into" })
    vim.keymap.set('n', '<F12>', dap.step_out, { desc = "Step Out" })
    vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set('n', '<Leader>Bb', dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set('n', '<Leader>Bc', set_cond_breakpoint, { desc = "Conditional Breakpoint" })
    vim.keymap.set('n', '<Leader>Bp', set_log_point, { desc = "Log Point" })
    vim.keymap.set('n', '<Leader>dr', dap.repl.open, { desc = "Open REPL" })
    vim.keymap.set('n', '<Leader>dl', dap.run_last, { desc = "Run Last" })
  end
}
