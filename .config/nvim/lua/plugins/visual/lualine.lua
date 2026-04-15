return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = "auto", 
                globalstatus = true,
                section_separators = { left = "", right = "" },
                disabled_filetypes = { "alpha" },
            },
            sections = {
                lualine_a = { { "mode", icon = "" } },
                lualine_b = { "branch", "diff" },
                lualine_c = { "filename" },
                lualine_x = { 
                    {
                        function() return require("fidget").status() end,
                        cond = function() return package.loaded["fidget"] ~= nil end,
                    },
                    "diagnostics" 
                },
                lualine_y = { "filetype" },
                lualine_z = { "location" },
            },
        })

        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", ctermbg = "NONE" })
                vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", ctermbg = "NONE" })
                require('lualine').setup({ options = { theme = "auto" } })
            end,
        })
    end,
}
