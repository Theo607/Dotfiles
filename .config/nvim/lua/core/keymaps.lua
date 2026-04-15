local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


vim.keymap.set("n", "<leader>w", ":w<CR>", opts) -- save
vim.keymap.set("n", "<leader>q", ":q<CR>", opts) -- quit

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

require("core.cheatsheet")
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {
    desc = "Show diagnostics under cursor",
})
