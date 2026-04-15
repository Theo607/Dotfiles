vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true 

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false
vim.opt.scrolloff = 8

vim.opt.clipboard = "unnamedplus"

vim.opt.termguicolors = true
vim.opt.fillchars = vim.opt.fillchars + { eob = " " }

if vim.loader then
  vim.loader.enable()
end

require("keymaps")
-- vim.keymap.set("v", "<", "<gv", opts)
-- vim.keymap.set("v", ">", ">gv", opts)
--
-- vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
-- vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
--
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {
--     desc = "Show diagnostics under cursor",
-- })

require("plugins")
