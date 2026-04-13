-- lua/plugins/comment.lua
return {
    -- Context-aware comment integration
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },

    -- Commenting plugin
    {
        "numToStr/Comment.nvim",
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        event = "VeryLazy",  -- lazy load after startup
        config = function()
            require("Comment").setup({
                -- Keymaps (default is fine, but explicit for clarity)
                toggler = {
                    line = "gcc",    -- toggle line comment
                    block = "gbc",   -- toggle block comment
                },
                opleader = {
                    line = "gc",     -- operator for line comment
                    block = "gb",    -- operator for block comment
                },
                -- Context-aware commenting for embedded languages
                pre_hook = function(ctx)
                    local ts_context = require("ts_context_commentstring.integrations.comment_nvim")
                    return ts_context.create_pre_hook()(ctx)
                end,
            })
        end,
    },
}

