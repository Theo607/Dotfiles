local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
    layouts = {
        {
            elements = { "scopes", "breakpoints", "stacks", "watches" },
            size = 40,
            position = "left",
        },
        {
            elements = { "repl", "console" },
            size = 10,
            position = "bottom",
        },
    },
})

-- Auto open/close UI
dap.listeners.after.event_initialized["dapui"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui"] = function()
    dapui.close()
end
