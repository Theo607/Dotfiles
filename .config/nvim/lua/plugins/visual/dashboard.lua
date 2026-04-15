return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Simple ASCII header
        dashboard.section.header.val = {
            "Welcome to Neovim",
        }

        -- Buttons
        dashboard.section.buttons.val = {
            dashboard.button("n", "New File", ":ene <BAR> startinsert<CR>"),
            dashboard.button("f", "Find File", ":Telescope find_files<CR>"),
            dashboard.button("g", "Live Grep", ":Telescope live_grep<CR>"),
            dashboard.button("q", "Quit", ":qa<CR>"),
        }

        dashboard.section.footer.val = ""

        alpha.setup(dashboard.config)
    end,
}
