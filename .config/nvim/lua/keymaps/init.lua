local map = vim.keymap.set

-- --- General/Utility ---
map("n", "<leader>ut", "<cmd>TransparentToggle<cr>", { desc = "Toggle Transparency" })
map("n", "<leader>zz", "<cmd>ZenMode<cr>", { desc = "Toggle Zen Mode" })
map("n", "<leader>zl", "<cmd>Limelight!!<cr>", { desc = "Toggle Limelight (Focus)" })
map("n", "<leader>th", "<cmd>ThemeHub<cr>", { desc = "Theme Picker" })
map("n", "<leader>sp", "<cmd>ChknToggle<cr>", { desc = "Toggle Scratchpad" })

-- --- Noice (Message Management) ---
map("n", "<leader>nm", "<cmd>Noice dismiss<CR>", { desc = "Dismiss All Messages" })
map("n", "<leader>nh", "<cmd>Noice history<CR>", { desc = "Message History" })
map("n", "<leader>nl", "<cmd>Noice last<CR>", { desc = "Last Message" })

-- Scroll Noice windows safely
map({ "n", "i", "s" }, "<c-f>", function()
  if not require("noice.util").try_scroll(4) then return "<c-f>" end
end, { silent = true, expr = true, desc = "Scroll Forward" })

map({ "n", "i", "s" }, "<c-b>", function()
  if not require("noice.util").try_scroll(-4) then return "<c-b>" end
end, { silent = true, expr = true, desc = "Scroll Backward" })

-- --- Navigation & Editing ---
map("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
map("n", "<leader>o", "<cmd>Oil<cr>", { desc = "Open Oil" })
map("n", "<leader>fo", "<cmd>Oil float<cr>", { desc = "Oil Float" })

-- Comments (using remap to trigger plug-in logic)
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle Comment" })
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle Comment" })
map("n", "<leader>bc", "gbc", { remap = true, desc = "Toggle Block Comment" })

-- --- Telescope ---
map("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find Files" })
map("n", "<leader>fg", function() require("telescope.builtin").live_grep() end, { desc = "Live Grep" })
map("n", "<leader>fb", function() require("telescope.builtin").buffers() end, { desc = "Buffers" })
map("n", "<leader>fh", function() require("telescope.builtin").help_tags() end, { desc = "Help" })
map("n", "<leader>fr", function() require("telescope.builtin").oldfiles() end, { desc = "Recent Files" })

-- --- Harpoon ---
map("n", "<leader>a", function() require("harpoon"):list():add() end, { desc = "Harpoon Add" })
map("n", "<leader>m", function() 
  local harpoon = require("harpoon")
  harpoon.ui:toggle_quick_menu(harpoon:list()) 
end, { desc = "Harpoon Menu" })
for i = 1, 4 do
  map("n", "<leader>" .. i, function() require("harpoon"):list():select(i) end, { desc = "Jump " .. i })
end

-- --- LSP (Autocmd ensures these only exist when LSP is active) ---
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }
    map("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "LSP: Go to Definition" })
    map("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "LSP: Show References" })
    map("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "LSP: Hover Info" })
    map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "LSP: Rename" })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "LSP: Code Action" })
    
    -- Format keymap (uses conform if available, falls back to LSP)
    map("n", "<leader>f", function()
      local ok, conform = pcall(require, "conform")
      if ok then
        conform.format({ bufnr = ev.buf, async = true, lsp_fallback = true })
      else
        vim.lsp.buf.format({ bufnr = ev.buf, async = true })
      end
    end, { buffer = ev.buf, desc = "Format Buffer" })
  end,
})

map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show Diagnostic Error" })

-- --- DAP (Debug) - Wrapped in functions to prevent startup errors ---
local dap_map = function(mode, lhs, rhs, desc)
  map(mode, lhs, function() 
    -- This pcall ensures we don't crash if DAP isn't loaded yet
    local ok, dap = pcall(require, "dap")
    if ok then
      if type(rhs) == "function" then rhs() else dap[rhs]() end
    end
  end, "Debug: " .. desc)
end

map("n", "<F5>", function() require("dap").continue() end, { desc = "Debug: Start" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "Debug: Step Over" })
map("n", "<leader>b", function() require("dap").toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Debug: Toggle UI" })
map("n", "<leader>dq", function() require("dap").terminate() end, { desc = "Debug: Terminate" })
