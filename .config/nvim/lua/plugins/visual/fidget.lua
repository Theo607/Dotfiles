return {
    "j-hui/fidget.nvim",
    opts = {
        progress = {
            poll_rate = 0,              
            suppress_on_insert = true, 
            display = {
                render_limit = 16,        
                done_icon = "󰄬",         
                done_style = "GruvboxGreen",
                progress_style = "GruvboxAqua",
            },
        },
        notification = {
            window = {
                winblend = 0,             
                relative = "editor",     
            },
        },
    },
}
