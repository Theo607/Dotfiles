return {
    "stevearc/dressing.nvim",
    config = function()
        require("dressing").setup({
            input = {
                enabled = true,
                default_prompt = "➤ ",
                insert_only = false,
                win_options = {
                    winblend = 10,
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
                },
            },
            select = {
                enabled = true,
                backend = { "telescope", "fzf_lua", "builtin" },
                telescope = nil, -- use default telescope options
                builtin = {
                    win_options = {
                        winblend = 10,
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
                    },
                },
            },
        })
    end,
}

