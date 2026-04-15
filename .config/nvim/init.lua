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

-- Clipboard
vim.opt.clipboard = "unnamedplus"

vim.opt.termguicolors = true
vim.opt.fillchars = vim.opt.fillchars + { eob = " " }

require("core.keymaps")
require("plugins")
