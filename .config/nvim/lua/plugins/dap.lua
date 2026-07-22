return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      "williamboman/mason.nvim",
    },
    event = "VeryLazy",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
      end

      map("n", "<leader>bb", function() dap.toggle_breakpoint() end, "Toggle Breakpoint")
      map("n", "<leader>bB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, "Breakpoint Condition")
      
      map("n", "<F5>", function() dap.continue() end, "Debug: Start/Continue")
      map("n", "<F10>", function() dap.step_over() end, "Debug: Step Over")
      map("n", "<F11>", function() dap.step_into() end, "Debug: Step Into")
      map("n", "<F12>", function() dap.step_out() end, "Debug: Step Out")
      
      map("n", "<leader>bu", function() dapui.toggle() end, "Toggle Debugger UI")
      map("n", "<leader>bt", function() dap.terminate() end, "Terminate Session")

      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
      local codelldb_cmd = mason_path .. "adapter/codelldb"

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_cmd,
          args = { "--port", "${port}" },
        },
      }

      dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }

      local systems_config = {
        {
          name = "Launch Local Binary",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.cpp = systems_config
      dap.configurations.c = systems_config
      dap.configurations.rust = systems_config
      dap.configurations.zig = systems_config

      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug File",
          request = "launch",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug Test",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
      }
    end,
  },
}
