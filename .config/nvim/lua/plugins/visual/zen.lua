return {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
        window = {
            backdrop = 0.95,
            width = 120,     
            options = {
                signcolumn = "no",    
                number = false,        
                relativenumber = false, 
                cursorline = false,   
                cursorcolumn = false,  
                foldcolumn = "0",       
                list = false,
            },
        },
        plugins = {
            options = {
                enabled = true,
                ruler = false,
                showcmd = false,
            },
            twilight = { enabled = false },
            lualine = { enabled = true },
        },
        on_open = function()
            vim.cmd("Limelight")
        end,
        on_close = function()
            vim.cmd("Limelight!")
        end,
    },
}
