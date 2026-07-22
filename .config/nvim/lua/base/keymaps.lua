local map = vim.keymap.set

map("n", "<leader>w", ":w<CR>")
map("n", "<leader>q", ":q!<CR>")

map("v", ">", ">gv")
map("v", "<", "<gv")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

local enter = require("base.enter")
map("n", "<leader>d", enter.open_dashboard)

local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
