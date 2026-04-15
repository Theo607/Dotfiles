-- lua/plugins/lastplace.lua
return {
    "ethanholz/nvim-lastplace",
    event = "BufReadPost",  -- lazy-load when a buffer is read
    config = function()
        require("nvim-lastplace").setup({
            lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
            lastplace_ignore_filetype = {
                "gitcommit", "gitrebase", "svn", "hgcommit",
            },
            lastplace_open_folds = true,  -- open folds when jumping
        })
    end,
}

