return {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
        input = {
            enabled = true,
            default_prompt = "  ", 
            trim_prompt = true,
            start_in_insert = true,
            win_options = {
                winblend = 0, 
                winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            },
            relative = "cursor", 
        },
        select = {
            enabled = true,
            backend = { "telescope", "fzf_lua", "builtin" },
            builtin = {
                win_options = {
                    winblend = 0, 
                    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                },
            },
        },
    },
}
