return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  -- Note: In 2026, many use 'opts' instead of 'config' for Treesitter 
  -- because it's safer, but if you use 'config', it must be wrapped like this:
  config = function()
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then return end

    configs.setup({
      ensure_installed = { "lua", "python", "rust", "cpp", "c", "typst" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
