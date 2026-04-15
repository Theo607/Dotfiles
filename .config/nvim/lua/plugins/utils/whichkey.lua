return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern", -- Clean 2026 look
    win = {
      border = "rounded",
      -- Transparency: matches your transparent.nvim setup
      padding = { 1, 2 },
    },
    -- Use your Gruvbox colors for the icons
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
    -- Document your groups so the menu looks organized
    spec = {
      { "<leader>b", group = "Buffer/Breakpoints" },
      { "<leader>c", group = "Code/AI" },
      { "<leader>d", group = "Debug" },
      { "<leader>f", group = "Find/Format" },
      { "<leader>n", group = "Noice/Notifications" },
      { "<leader>s", group = "Search/Scratch" },
      { "<leader>u", group = "UI/Toggle" },
      { "<leader>x", group = "Trouble/Quickfix" },
      { "<leader>z", group = "Zen/Focus" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps",
    },
  },
}
