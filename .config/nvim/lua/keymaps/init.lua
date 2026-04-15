local map = vim.keymap.set


map("n", "]i", function()
    local ok, illuminate = pcall(require, "illuminate")
    if ok then illuminate.goto_next_reference() end
end, { desc = "Next occurrence" })

map("n", "[i", function()
    local ok, illuminate = pcall(require, "illuminate")
    if ok then illuminate.goto_prev_reference() end
end, { desc = "Previous occurrence" })

map("n", "<leader>zl", "<cmd>Limelight!!<cr>", { desc = "Toggle Limelight (Focus)" })

map("n", "<leader>nm", "<cmd>Noice dismiss<CR>", { desc = "Dismiss All Messages" })
map("n", "<leader>nh", "<cmd>Noice history<CR>", { desc = "Message History" })
map("n", "<leader>nl", "<cmd>Noice last<CR>", { desc = "Last Message" })

map({ "n", "i", "s" }, "<c-f>", function()
  if not require("noice.util").try_scroll(4) then
    return "<c-f>"
  end
end, { silent = true, expr = true, desc = "Scroll Forward" })

map({ "n", "i", "s" }, "<c-b>", function()
  if not require("noice.util").try_scroll(-4) then
    return "<c-b>"
  end
end, { silent = true, expr = true, desc = "Scroll Backward" })

map("n", "<leader>th", "<cmd>ThemeHub<cr>", { desc = "Theme Picker (Hub)" })

map("n", "<leader>ut", "<cmd>TransparentToggle<cr>", { desc = "Toggle Transparency" })

map("n", "<leader>zz", "<cmd>ZenMode<cr>", { desc = "Toggle Zen Mode" })
