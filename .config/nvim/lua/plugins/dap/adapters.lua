local dap = require("dap")

-- Mason installs adapters
require("mason-nvim-dap").setup({
    ensure_installed = {
        "codelldb",  -- C/C++
        "python",    -- Python
    },
    automatic_installation = true,
})

-- C / C++ (LLDB)
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    },
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}

dap.configurations.c = dap.configurations.cpp

-- Python
dap.adapters.python = {
    type = "executable",
    command = "python",
    args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
            return "python"
        end,
    },
}
dap.adapters.nasm = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    }
}

dap.configurations.asm = {
    {
        name = "Debug NASM with codelldb",
        type = "nasm",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
        args = {},
    },
}


