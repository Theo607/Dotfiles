local opts = "base.options"
local globs = "base.globals"
local keys = "base.keymaps"
local theme = "base.theme"
local enter = "base.enter"

local function set_values(dest, opts)
    for key, val in pairs(opts) do
        dest[key] = val
    end
end

set_values(vim.opt, require(opts))
set_values(vim.g, require(globs))

require(enter).run()

require("config.lazy")
pcall(require, theme)
require(keys)
require("lualine").setup({
    options = { theme = "auto", },
})
