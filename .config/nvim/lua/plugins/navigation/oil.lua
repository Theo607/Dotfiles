-- lua/plugins/oil.lua
return {
    "stevearc/oil.nvim",
    opts = {
        -- Oil opens directories in the current buffer
        view_options = {
            show_hidden = true, -- show dotfiles
            -- Optional: sort folders before files
            sort_column = 1,
        },
    },
    config = function(_, opts)
        local oil = require("oil")
        local actions = require("oil.actions") -- import actions table

        -- Setup Oil
        oil.setup(vim.tbl_extend("force", opts, {
            keymaps = {
                ["<CR>"] = actions.select,       -- Enter to open file/folder
                ["<C-v>"] = actions.select_vsplit, -- Open in vertical split
                ["<C-s>"] = actions.select_split,  -- Open in horizontal split
                ["<C-t>"] = actions.select_tab,    -- Open in new tab
                ["-"] = actions.parent,             -- Go up one directory
                ["r"] = actions.refresh,            -- Refresh
                ["a"] = actions.create,             -- Create file/folder
                ["d"] = actions.delete,             -- Delete
                ["R"] = actions.rename,             -- Rename
                ["y"] = actions.copy,               -- Copy file/folder
                ["p"] = actions.paste,              -- Paste copied file/folder
                ["q"] = actions.close,              -- Quit Oil buffer
            },
        }))

        -- Optional: keymap to open Oil in the current buffer
        vim.keymap.set("n", "<leader>o", function()
            oil.open()
        end, { desc = "Open Oil file manager" })
    end,
}

