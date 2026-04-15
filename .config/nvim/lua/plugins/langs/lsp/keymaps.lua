local M = {}

function M.setup(bufnr)
    local opts = { buffer = bufnr, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    -- Add formatting keymap
    vim.keymap.set("n", "<leader>f", function()
    local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
    for _, client in ipairs(clients) do
        if client.supports_method and client.supports_method("textDocument/formatting") then
            vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            return
        end
    end
    vim.notify("No LSP client supports formatting!", vim.log.levels.WARN)
    end, { buffer = true, desc = "Format buffer" })
end

return M

