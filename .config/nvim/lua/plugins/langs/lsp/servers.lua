return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_lsp = require("cmp_nvim_lsp")

    mason.setup({ ui = { border = "rounded" } })

    -- The servers we want to manage
    local servers = {
      clangd = { cmd = { "clangd", "--background-index" } },
      lua_ls = {
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } }
        }
      },
      pyright = {},
      bashls = {},
      ts_ls = {},
      jsonls = {},
      yamlls = {},
      rust_analyzer = {},
    }

    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = true,
    })

    local capabilities = cmp_lsp.default_capabilities()

    -- NEVIM 0.11+ NATIVE WAY:
    for name, config in pairs(servers) do
      -- 1. Create the config using the new native API
      vim.lsp.config(name, {
        cmd = config.cmd,
        settings = config.settings,
        capabilities = capabilities,
        filetypes = config.filetypes,
      })

      -- 2. Enable it (This replaces .setup())
      vim.lsp.enable(name)
    end

    -- Polish for the LSP UI
    require('lspconfig.ui.windows').default_options.border = 'rounded'
  end,
}
