-- lua/plugins/fidget.lua
return {
    "j-hui/fidget.nvim",
    tag = "legacy",  -- optional, pick latest stable
    config = function()
        require("fidget").setup({
            text = {
                spinner = "dots",  -- options: 'dots', 'line', etc.
                done = "✔",
                commenced = "Started",
                completed = "Completed",
            },
            align = {
                bottom = true,
                right = true,
            },
            window = {
                blend = 0,
            },
            fmt = {
                task = function(task_name, message, percentage)
                    return string.format("%s: %s [%s]", task_name, message, percentage or 0)
                end,
            },
        })
    end,
}

