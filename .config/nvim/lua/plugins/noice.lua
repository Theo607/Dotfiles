-- lua/plugins/noice.lua
return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    opts = {
        cmdline = {
            enabled = true,         -- enable cmdline UI
            view = "cmdline_popup", -- nicer popup style
        },
        messages = {
            enabled = true,         -- enable messages UI
        },
        popupmenu = {
            enabled = true,         -- better popup menu
            backend = "nui",        -- use NUI
        },
        notify = {
            enabled = true,
            view = "notify",
        },
        routes = {
            {
                view = "cmdline",
                filter = { event = "msg_showmode" },
            },
        },
        presets = {
            bottom_search = true,      -- search in bottom popup
            command_palette = true,    -- nicer command palette
            long_message_to_split = true, -- long messages go to split
            inc_rename = true,         -- nicer LSP rename UI
            lsp_doc_border = true,     -- border for LSP hover/doc
        },
    },
    config = function(_, opts)
        require("noice").setup(opts)

        require("notify").setup({
          -- Use black, or any hex color you like
          background_colour = "#1e1e2e",  -- example dark gray-purple
        })
        -- Optional: keymaps for Noice
        vim.keymap.set("n", "<leader>nm", "<cmd>Noice dismiss<CR>", { desc = "Dismiss messages" })
        vim.keymap.set("n", "<leader>nh", "<cmd>Noice history<CR>", { desc = "Show message history" })
    end,
}

