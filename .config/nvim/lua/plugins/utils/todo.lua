return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        signs = true,
        gui_style = {
            fg = "BOLD",
            bg = "NONE",
        },
        highlight = {
            multiline = true,
            before = "", 
            keyword = "fg", 
            after = "fg",    
            pattern = [[.*<(KEYWORDS)\s*:]], 
            comments_only = true, 
        },
        colors = {
            error   = { "DiagnosticError", "ErrorMsg", "#fb4934" }, -- Gruvbox Red
            warning = { "DiagnosticWarn", "WarningMsg", "#fabd2f" }, -- Gruvbox Yellow
            info    = { "DiagnosticInfo", "#83a598" },               -- Gruvbox Blue
            hint    = { "DiagnosticHint", "#8ec07c" },               -- Gruvbox Aqua
            default = { "Identifier", "#d3869b" },                   -- Gruvbox Purple
            test    = { "Identifier", "#b8bb26" },                   -- Gruvbox Green
        },
    },
}
