return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "jay-babu/mason-nvim-dap.nvim",
    "williamboman/mason.nvim",
  },
  config = function()
    local dap = require("dap")
    local mason_dap = require("mason-nvim-dap")

    -- 1. Bridge Mason and DAP
    mason_dap.setup({
      ensure_installed = { "codelldb", "python" },
      automatic_installation = true,
      handlers = {}, -- Uses default lspconfig-style handshakes
    })

    -- 2. C / C++ / Rust / ASM (via codelldb)
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
      },
    }

    local lldb_config = {
      {
        name = "Launch Binary",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    dap.configurations.cpp = lldb_config
    dap.configurations.c = lldb_config
    dap.configurations.rust = lldb_config
    dap.configurations.asm = lldb_config -- Great for your NASM work

    -- 3. Python (Debugpy)
    dap.adapters.python = {
      type = "executable",
      command = "python",
      args = { "-m", "debugpy.adapter" },
    }

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch current file",
        program = "${file}",
        pythonPath = function()
          return "python"
        end,
      },
    }

    -- 4. Aesthetic: Rounded borders for DAP UI elements
    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "" })
  end,
}
