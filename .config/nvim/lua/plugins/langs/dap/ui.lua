return {
  "rcarriga/nvim-dap-ui",
  dependencies = { 
    "mfussenegger/nvim-dap", 
    "nvim-neotest/nvim-nio" -- Required dependency for modern dap-ui
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          position = "bottom",
          size = 10,
        },
      },
    })

    -- Auto open/close UI logic
    dap.listeners.after.event_initialized["dapui"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui"] = function()
      dapui.close()
    end

    -- Aesthetic: Ensure DAP floating windows are rounded
    -- This matches your transparent glass/rounded look
    dap.defaults.fallback.external_terminal = {
      command = '/usr/bin/ghostty', -- Or your preferred terminal
      args = { '-e' },
    }
  end,
}
