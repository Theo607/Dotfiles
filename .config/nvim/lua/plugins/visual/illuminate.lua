-- lua/plugins/illuminate.lua
return {
    "RRethy/vim-illuminate",
    event = "BufReadPost", -- lazy load
    config = function()
        require("illuminate").configure({
            delay = 100,           -- delay in ms before highlighting
            filetypes_denylist = { -- optionally disable for some filetypes
                "NvimTree",
                "dashboard",
                "packer",
                "oil",
            },
            under_cursor = true, -- highlight word under cursor
        })

        -- Optional keymaps to jump between references
        vim.keymap.set("n", "]i", function()
            require("illuminate").goto_next_reference()
        end, { desc = "Next occurrence" })

        vim.keymap.set("n", "[i", function()
            require("illuminate").goto_prev_reference()
        end, { desc = "Previous occurrence" })
    end,
}
