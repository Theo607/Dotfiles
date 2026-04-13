-- Tab and indentation settings
vim.opt.expandtab = true       -- use spaces instead of tabs
vim.opt.shiftwidth = 4         -- indentation width
vim.opt.tabstop = 4            -- tab width
vim.opt.smartindent = true     -- smart auto-indenting

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true      -- highlight current line

-- Search highlighting
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Wrap and scrolling
vim.opt.wrap = false
vim.opt.scrolloff = 8          -- keep 8 lines visible above/below cursor

-- Clipboard
vim.opt.clipboard = "unnamedplus"

vim.opt.termguicolors = true
vim.opt.fillchars = vim.opt.fillchars + { eob = " " }

