return {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("illuminate").configure({
            delay = 200,
            filetypes_denylist = {
                "NvimTree",
                "dashboard",
                "alpha",
                "oil",
                "lazy",
                "TelescopePrompt",
            },
            under_cursor = true,
            large_file_cutoff = 2000,
        })

        local function set_illuminate_hl()
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underline = true, fg = "#fabd2f" }) -- GruvboxYellow
        end

        set_illuminate_hl()
    end,
}
