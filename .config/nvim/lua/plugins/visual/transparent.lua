return {
    "tribela/transparent.nvim",
    event = "VimEnter",
    opts = {
        extra_groups = {
            "NormalFloat",
            "NvimTreeNormal", 
            "NvimTreeNormalNC",
            "EndOfBuffer",
            "LineNr",   
            "CursorLine",
            "CursorLineNr",
            "StatusLine",
            "StatusLineNC",
            "WinBar",    
            "WinBarNC",
            "FloatBorder",
            "Pmenu",      
            "SignColumn",  
        },
        exclude_groups = {},
    },
}
