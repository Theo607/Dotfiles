return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name)
                return name == ".." or name == ".git"
            end,
        },
        float = {
            padding = 2,
            max_width = 0,
            max_height = 0,
            border = "rounded",
            win_options = {
                winblend = 0,
            },
        },
    },
}
