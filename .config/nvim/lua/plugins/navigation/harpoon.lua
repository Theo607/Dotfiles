return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        settings = {
            save_on_toggle = true,
            sync_on_ui_close = true,
        },
    },
    config = function(_, opts)
        local harpoon = require("harpoon")
        harpoon:setup(opts)

    end,
}
