return {
  "folke/zen-mode.nvim",
  opts = {},

  config = function()
    vim.keymap.set("n", "<leader>cz", ":Zen<CR>", { desc = "Toggle Zen Mode" })
  end,
}

