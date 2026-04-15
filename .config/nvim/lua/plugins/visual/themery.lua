return {
    "erl-koenig/theme-hub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "rktjmp/lush.nvim"
    },
    config = function()
        require("theme-hub").setup({
            persistent = true,
        })

        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                local hl_groups = {
                    "Normal", "NormalFloat", "NormalNC", 
                    "SignColumn", "LineNr", "FoldColumn"
                }
                for _, group in ipairs(hl_groups) do
                    vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
                end
            end,
        })
    end,
}
