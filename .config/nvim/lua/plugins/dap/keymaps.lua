local dap = require("dap")
local dapui = require("dapui")

vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>B", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional breakpoint" })

vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open DAP REPL" })
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate debug" })
vim.keymap.set("n", "<leader>dk", require("dap").up, { desc = "Stack up" })
vim.keymap.set("n", "<leader>dj", require("dap").down, { desc = "Stack down" })


