return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",   -- lazy load after startup
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",   -- `auto` tries to match current colorscheme
                    component_separators = "|",
                    section_separators = "",
                }
            })
        end
    }
}

