return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")

        telescope.setup({
            defaults = {
                prompt_prefix = "🔍 ",
                file_ignore_patterns = { "node_modules", ".git/" },
            },
        })

        -- Keymaps
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
        vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find TODOs" })
    end,
}

