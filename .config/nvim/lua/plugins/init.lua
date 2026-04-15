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

    require("plugins.visual"),
    require("plugins.navigation"),
    require("plugins.langs"),

    require("plugins.comment"),
    require("plugins.todo"),
    require("plugins.impatient"),
    require("plugins.dressing"),
    require("plugins.lastplace"),
    require("plugins.chunk"),

    require("plugins.copilot"),
    require("plugins.autopairs"),
    require("plugins.autotag"),
    require("plugins.surround"),
    require("plugins.repeat"),
}

require("lazy").setup(plugins)

