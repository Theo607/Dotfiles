-- lua/plugins/init.lua

-- bootstrap Lazy.nvim (optional but recommended)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	require("plugins.lualine"),
	require("plugins.treesitter"),
    require("plugins.lsp"),
    require("plugins.finder"),
    require("plugins.harpoon"),
    require("plugins.dashboard"),
    require("plugins.git"),
    require("plugins.snippets"),
    require("plugins.copilot"),
    require("plugins.autopairs"),
    require("plugins.autotag"),
    require("plugins.dap"),
    require("plugins.surround"),
    require("plugins.repeat"),
    require("plugins.comment"),
    require("plugins.todo"),
    require("plugins.impatient"),
    require("plugins.dressing"),
    require("plugins.lastplace"),
    require("plugins.limelight"),
    require("plugins.oil"),
    require("plugins.noice"),
    require("plugins.fidget"),
    require("plugins.illuminate"),
    require("plugins.smear"),
    require("plugins.chunk"),
    require("plugins.markview"),
    require("plugins.themery"),
    require("plugins.scratch"),
    require("plugins.zen"),
    -- require("plugins.transparent"),
    -- require("plugins.markdown_preview"),
}

-- plugins
require("lazy").setup(plugins)

