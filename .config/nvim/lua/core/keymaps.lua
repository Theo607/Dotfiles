-- lua/core/keymaps.lua

local opts = { noremap = true, silent = true }

-- Leader key (must be set first)
vim.g.mapleader = " " -- space as leader key
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Save and quit
vim.keymap.set("n", "<leader>w", ":w<CR>", opts) -- save
vim.keymap.set("n", "<leader>q", ":q<CR>", opts) -- quit

-- Split windows
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", opts) -- vertical split
vim.keymap.set("n", "<leader>sh", ":split<CR>", opts)  -- horizontal split
vim.keymap.set("n", "<leader>se", "<C-w>=", opts)      -- equalize splits
vim.keymap.set("n", "<leader>sx", ":close<CR>", opts)  -- close current split

-- Move between splits
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", opts)

-- Toggle relative/absolute line numbers
local function toggle_numbers()
    if vim.wo.relativenumber then
        vim.wo.relativenumber = false
        vim.wo.number = true
    else
        vim.wo.relativenumber = true
        vim.wo.number = true
    end
end
vim.keymap.set("n", "<leader>n", toggle_numbers, opts)
-- Exit insert mode quickly
vim.keymap.set("i", "jk", "<ESC>", opts)
vim.keymap.set("i", "kj", "<ESC>", opts)
-- Stay in indent mode when shifting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move selected text up/down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Open dashboard
vim.keymap.set("n", "<leader>d", function()
    -- Only open in a new tab
    if vim.api.nvim_buf_get_name(0) ~= "" then
        vim.cmd.tabnew()
    end
    require("alpha").start(false)
end, { desc = "Open Dashboard" })

require("core.cheatsheet")
-- Normal mode
vim.api.nvim_set_keymap('n', 'gC', '~', { noremap = true, silent = true })

-- Visual mode
vim.api.nvim_set_keymap('v', 'gC', '~', { noremap = true, silent = true })


vim.keymap.set("n", "q", "q")
-- Toggle Twilight (focus mode)
vim.keymap.set("n", "<leader>z", function()
    require("twilight").toggle()
end, { desc = "Toggle Twilight (focus mode)" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {
    desc = "Show diagnostics under cursor",
})

vim.keymap.set("n", "<leader>th", ":Themery<CR>")
