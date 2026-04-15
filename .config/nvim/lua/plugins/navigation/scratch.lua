return {
    "ericrswanny/chkn.nvim",
    lazy = true, 
    cmd = { "ChknToggle", "ChknOpen", "ChknClose" },
    opts = {
        width = 80,
        height = 20,
        border = "rounded", 
        persistent = true,   
    },
    config = function(_, opts)
        require("chkn").setup(opts)
        
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "chkn",
            callback = function()
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#fabd2f", bg = "NONE" }) -- Gruvbox Yellow Border
            end,
        })
    end,
}
