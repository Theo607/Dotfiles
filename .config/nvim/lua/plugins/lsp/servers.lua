return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason_lsp = require("mason-lspconfig")

        -- Mason: install servers automatically
        mason_lsp.setup({
            ensure_installed = {
                "clangd",
                "lua_ls",
                "pyright",
                "bashls",
                "ts_ls",
                "jsonls",
                "yamlls",
                "rust_analyzer",
            },
            automatic_installation = true,
        })

        -- Common LSP capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        -- Buffer-local keymaps
        local on_attach = function(_, bufnr)
            require("plugins.lsp.keymaps").setup(bufnr)
        end

        -- Define server configurations
        local servers = {
            clangd = {
                cmd = { "clangd", "--background-index" },
                filetypes = { "c", "cpp" },
            },
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            },
            pyright = {},
            bashls = {},
            ts_ls = {},
            jsonls = {},
            yamlls = {},
            rust_analyzer = {},
        }

        -- Configure and enable each server using the new API
        for name, config in pairs(servers) do
            config.on_attach = on_attach
            config.capabilities = capabilities

            -- Define the config
            vim.lsp.config(name, config)

            -- Enable the server for matching buffers
            vim.lsp.enable(name)
        end
    end,
}

