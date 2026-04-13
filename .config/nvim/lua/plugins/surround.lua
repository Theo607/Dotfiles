return {
    {
        "kylechui/nvim-surround",
        version = "*", -- Use stable release
        config = function()
            require("nvim-surround").setup({
                -- Configuration options (defaults are usually fine)
                keymaps = {
                    insert = "<C-g>s",   -- Add surrounding in insert mode
                    insert_line = "<C-g>S",
                    normal = "ys",       -- Add surrounding in normal mode
                    normal_line = "yS",
                    delete = "ds",       -- Delete surrounding
                    change = "cs",       -- Change surrounding
                },
                -- You can customize more, like surrounds for markdown, html, etc.
            })
        end,
    },
}

