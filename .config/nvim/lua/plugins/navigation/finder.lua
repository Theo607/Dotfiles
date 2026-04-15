return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                prompt_prefix = "   ", 
                selection_caret = "󰁔 ",
                path_display = { "smart" },
                file_ignore_patterns = { "node_modules", ".git/", ".cache" },
                
                winblend = 0,
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                    },
                },
                borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            },
        })
    end,
}
