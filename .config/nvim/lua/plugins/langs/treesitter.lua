return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "astro", "bash", "c", "cpp", "css", "diff", "go", "gomod",
        "gowork", "gosum", "graphql", "html", "java", "javascript",
        "jsdoc", "json", "lua", "luadoc", "luap", "markdown",
        "markdown_inline", "python", "query", "regex", "toml",
        "tsx", "typescript", "vim", "vimdoc", "yaml", "ruby", "zig",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      -- Use a safe pcall to handle the 1.0.0 breaking change
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if ok then
        configs.setup(opts)
      else
        require("nvim-treesitter").setup(opts)
      end
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      multiwindow = true,
      max_lines = 3,
    },
    config = function(_, opts)
      require("treesitter-context").setup(opts)
      -- Gruvbox transparency fix for context headers
      vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "NONE", italic = true })
      vim.api.nvim_set_hl(0, "TreesitterContextBottom", { sp = "#928374", underline = true })
    end,
  },
}
