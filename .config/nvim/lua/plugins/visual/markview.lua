return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-treesitter/nvim-treesitter",
        "saghen/blink.cmp"
    },
    opts = {
        preview = {
            filetypes = { "markdown", "quarto", "norg" },
            ignore_buftypes = {},
        },
        code_blocks = {
            enable = true,
            style = "minimal",
            hl = "GruvboxBg0",  
        },
        headings = {
            enable = true,
            shift_width = 1,
            icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        }
    }
}
