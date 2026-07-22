return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "classic", 
    delay = 200, -- Shows up quickly if you pause after pressing leader
    spec = {
      -- Register distinct folder labels for your leader configurations
      { "<leader>f", group = "Format/File" },
      { "<leader>c", group = "Code/Refactor" },
      
      -- Structural labels for standard Neovim navigation
      { "g", group = "Goto / LSP Navigation" },
      { "[", group = "Previous Target" },
      { "]", group = "Next Target" },
    },
  },
  config = function(_, opts)
    require("which-key").setup(opts)
  end,
}
