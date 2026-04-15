return {
  "nvim-java/nvim-java",
  dependencies = {
    "nvim-java/lua-async-await",
    "nvim-java/nvim-java-core",
    "nvim-java/nvim-java-test",
    "nvim-java/nvim-java-dap",
    "MunifTanjim/nui.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
  },
  config = function()
    -- 1. Initialize the nvim-java framework
    require("java").setup()

    -- 2. Use the Neovim 0.11+ native API to configure JDTLS
    -- This replaces lspconfig.jdtls.setup({})
    vim.lsp.config("jdtls", {
      -- You can add specific jdtls settings here if needed
      -- e.g., settings = { java = { ... } }
    })

    -- 3. Enable the server
    vim.lsp.enable("jdtls")
  end,
}
