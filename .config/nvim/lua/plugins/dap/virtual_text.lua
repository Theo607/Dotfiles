return {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
        require("nvim-dap-virtual-text").setup({
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = true,
            show_stop_reason = true,
            commented = false, -- show inline, not commented
            virt_text_pos = "eol", -- end of line
            all_frames = false, -- only current frame (recommended)
        })
    end,
}

