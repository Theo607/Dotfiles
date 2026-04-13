-- lua/plugins/git.lua
return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "│" },
                    change = { text = "│" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
                numhl = false,
                linehl = false,
                watch_gitdir = {
                    interval = 1000,
                    follow_files = true,
                },
                current_line_blame = true, -- show blame info at end of line
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol", -- end of line
                    delay = 500,
                },
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- use default
            })

            local gs = package.loaded.gitsigns

            -- Keymaps for navigating/staging hunks
            vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Next Git hunk" })
            vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "Previous Git hunk" })
            vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
            vim.keymap.set("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                { desc = "Stage visual selection hunk" })
            vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
            vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
            vim.keymap.set("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                { desc = "Reset visual selection hunk" })
            vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
            vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
            vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
            vim.keymap.set("n", "<leader>hb", function()
                local ok, err = pcall(function()
                    gs.blame_line({ full = true })
                end)
                if not ok then
                    vim.notify("Blame failed: " .. tostring(err), vim.log.levels.WARN)
                end
            end, { desc = "Blame line" })
            vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle blame" })
            vim.keymap.set("n", "<leader>hd", gs.diffthis, { desc = "Git diff current file" })
            vim.keymap.set("n", "<leader>hD", function() gs.diffthis("~") end,
                { desc = "Git diff against previous commit" })
            vim.keymap.set("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted lines" })
        end,
    },
}
