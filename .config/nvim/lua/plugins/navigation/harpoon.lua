return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        -- REQUIRED: Harpoon 2.0 needs setup called
        harpoon:setup()

        -- Add the current file to harpoon
        vim.keymap.set("n", "<leader>a", function() 
            harpoon:list():add() 
        end, { desc = "Add file to Harpoon" })

        -- Toggle harpoon menu
        vim.keymap.set("n", "<leader>m", function() 
            harpoon.ui:toggle_quick_menu(harpoon:list()) 
        end, { desc = "Harpoon Menu" })

        -- Jump to harpoon files by index (1-9)
        for i = 1, 9 do
            vim.keymap.set("n", "<leader>" .. i, function()
                harpoon:list():select(i)
            end, { desc = "Harpoon " .. i })
        end
    end,
}
