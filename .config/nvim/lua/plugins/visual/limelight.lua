return {
    "junegunn/limelight.vim",
    cmd = "Limelight", 
    config = function()
        vim.g.limelight_conceal_guifg = "#3c3836"
        vim.g.limelight_paragraph_span = 1 
    end,
}
