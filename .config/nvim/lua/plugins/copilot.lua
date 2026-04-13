-- lua/plugins/copilot.lua
return {
    "github/copilot.vim",
    config = function()
        -- Optional: make Copilot start enabled
        vim.g.copilot_no_tab_map = true -- we’ll define our own keymaps
        vim.g.copilot_filetypes = {
            ["*"] = true,               -- enable for all filetypes
        }
        vim.g.copilot_enabled = false

        -- Keymap to accept Copilot suggestion
        vim.keymap.set("i", "<C-L>", function()
            local copilot = vim.fn["copilot#Accept"]()
            if copilot == vim.NIL then
                return ""
            end
            return copilot
        end, { expr = true, silent = true, desc = "Accept Copilot suggestion" })

        -- Keymap to trigger Copilot manually
        vim.keymap.set("n", "<leader>co", ":Copilot enable<CR>", { desc = "Enable Copilot" })
        vim.keymap.set("n", "<leader>cd", ":Copilot disable<CR>", { desc = "Disable Copilot" })
    end,
}
