-- lua/plugins/copilot.lua
return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
        suggestion = {
            enabled = true,
            auto_trigger = true,
            debounce = 75,
            keymap = {
                accept = "<C-l>",
                accept_word = false,
                accept_line = false,
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
            },
        },
        panel = { enabled = false },
        filetypes = {
            markdown = true, 
            help = false,
            gitcommit = false,
        },
    },
    config = function(_, opts)
        require("copilot").setup(opts)
        
        vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#928374", italic = true })
    end,
}
