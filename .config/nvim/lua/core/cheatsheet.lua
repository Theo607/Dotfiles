-- lua/core/cheatsheet.lua
local M = {}
M.current_buf = nil -- track the currently open buffer

-- Sections of keymaps
local sections = {
    General = {
        { "<leader>?", "Show cheatsheet" },
        { "<leader>d", "Open Dashboard" },
        { "jk / kj",   "Exit insert mode" },
        { "<leader>n", "Toggle relative/absolute line numbers" },
        { "< / >",     "Indent in visual mode" },
        { "<A-j>",     "Move selected text down" },
        { "<A-k>",     "Move selected text up" },
        { "<leader>z", "Toggle Twilight (focus mode)" },
    },

    Windows_Buffers = {
        { "<leader>sv", "Vertical split" },
        { "<leader>sh", "Horizontal split" },
        { "<leader>se", "Equalize splits" },
        { "<leader>sx", "Close split" },
        { "<C-h>",      "Move to left split" },
        { "<C-j>",      "Move to below split" },
        { "<C-k>",      "Move to above split" },
        { "<C-l>",      "Move to right split" },
        { "<S-l>",      "Next buffer" },
        { "<S-h>",      "Previous buffer" },
        { "<leader>bd", "Delete buffer" },
    },
    LSP = {
        { "gd",         "Go to definition" },
        { "grr",        "References" },
        { "K",          "Hover" },
        { "<leader>rn", "Rename symbol" },
        { "<leader>ca", "Code action" },
        { "<leader>f",  "Format buffer" },
    },
    Harpoon = {
        { "<leader>a", "Add file to Harpoon" },
        { "<leader>m", "Harpoon menu" },
        { "1–9", "Jump to Harpoon file" },
    },
    Debugging = {
        { "<F5>",  "Debug: Start/Continue" },
        { "<F10>", "Debug: Step Over" },
        { "<F11>", "Debug: Step Into" },
        { "<F12>", "Debug: Step Out" },
        { "b",     "Toggle breakpoint" },
        { "B",     "Conditional breakpoint" },
        { "dr",    "Open DAP REPL" },
        { "du",    "Toggle DAP UI" },
        { "dj",    "Stack down" },
        { "dk",    "Stack up" },
    },
    Git = {
        { "hp", "Preview hunk" },
        { "hs", "Stage hunk" },
        { "hr", "Reset hunk" },
        { "hu", "Undo stage hunk" },
        { "hR", "Reset buffer" },
        { "hS", "Stage buffer" },
        { "hd", "Git diff current file" },
        { "hD", "Git diff against previous commit" },
        { "tb", "Toggle blame" },
        { "hb", "Blame line" },
    },
    Copilot = {
        { "<C-L>", "Accept Copilot suggestion" },
        { "co",    "Enable Copilot" },
        { "cd",    "Disable Copilot" },
    },
    Snippets = {
        { "da", "Enable LuaSnip snippets" },
        { "ds", "Disable LuaSnip snippets" },
    },
    Surround = {
        { "ys{motion}{char}", "Add surround" },
        { "cs{from}{to}",     "Change surround" },
        { "ds{char}",         "Delete surround" },
        { "yss{char}",        "Surround current line" },
        { "<C-g>s",           "Insert mode add surround" },
        { "<C-g>S",           "Insert mode add surround to line" },
    },
    Search = {
        { "<leader>ff", "Find files" },
        { "<leader>fg", "Live grep" },
        { "<leader>ft", "Find all TODOs (Telescope)" },
        { "<leader>fb", "Buffers" },
        { "<leader>fh", "Help tags" },
    },
    Comments = { -- new section
        { "gcc",               "Toggle line comment [n]" },
        { "gbc",               "Toggle block comment [n]" },
        { "gc{motion}",        "Comment motion [n]" },
        { "gb{motion}",        "Comment block motion [n]" },
        { "gc / gb in visual", "Toggle comment on selection [v]" },
    },
    Vim_Repeat = {
        { ".", "Repeat last change / plugin operator (surround, comment, etc.)" },
    },
    TODO = {
        { "]t", "Next TODO comment" },
        { "[t", "Previous TODO comment" },
    },

    Oil = {
        { "<leader>o", "Open Oil file manager" },
        { "<CR>",      "Open file/folder" },
        { "<C-v>",     "Open in vertical split" },
        { "<C-s>",     "Open in horizontal split" },
        { "<C-t>",     "Open in new tab" },
        { "-",         "Go up one directory" },
        { "r",         "Refresh directory" },
        { "a",         "Create file/folder" },
        { "d",         "Delete file/folder" },
        { "R",         "Rename file/folder" },
        { "y",         "Copy file/folder" },
        { "p",         "Paste copied file/folder" },
        { "q",         "Close Oil buffer" },
    },
    Noice_UI = {
        { "<leader>nm", "Dismiss messages" },
        { "<leader>nh", "Show message history" },
    },
    Fidget = {
        { "fidget.nvim", "Shows LSP progress automatically" },
        { "]i",          "Jump to next occurrence (vim-illuminate)" },
        { "[i",          "Jump to previous occurrence (vim-illuminate)" },
    }

}

local function close_buf()
    if M.current_buf and vim.api.nvim_buf_is_valid(M.current_buf) then
        vim.api.nvim_buf_delete(M.current_buf, { force = true })
        M.current_buf = nil
    end
end

local function show_section(name)
    close_buf()

    -- Create buffer
    local buf = vim.api.nvim_create_buf(false, true) -- [listed=false, scratch=true]
    M.current_buf = buf

    -- Build lines
    local lines = { "=== " .. name .. " ===", "" }
    for _, km in ipairs(sections[name]) do
        table.insert(lines, string.format("%-15s → %s", km[1], km[2]))
    end
    table.insert(lines, "")
    table.insert(lines, "<Esc> to go back / q to close")

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- Get screen size for floating window
    local width = math.floor(vim.o.columns * 0.5)
    local height = math.floor(vim.o.lines * 0.5)
    local row = math.floor((vim.o.lines - height) / 2 - 1)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Open floating window
    vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    vim.api.nvim_buf_set_option(buf, "modifiable", false)

    -- Keymaps to close / go back
    vim.keymap.set("n", "<Esc>", function()
        close_buf()
        M.show()
    end, { buffer = buf, silent = true })
    vim.keymap.set("n", "q", close_buf, { buffer = true, silent = true })
end

function M.show()
    -- Main menu using vim.ui.select
    local choices = {}
    for sec, _ in pairs(sections) do table.insert(choices, sec) end
    table.sort(choices)

    vim.ui.select(choices, { prompt = "Select cheatsheet section:" }, function(choice)
        if choice then
            show_section(choice)
        end
    end)
end

vim.keymap.set("n", "<leader>?", M.show, { desc = "Show keymap cheatsheet" })

return M
