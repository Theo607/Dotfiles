return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "n",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescriptreact = { "prettierd" },
      java = { "google-java-format" },
      json = { "prettierd" },
      html = { "prettierd" },
      css = { "prettierd" },
      scss = { "prettierd" },
      markdown = { "prettierd" },
      yaml = { "prettierd" },
      lua = { "stylua" },
      python = { "black", "yapf" },
      rust = { "rustfmt" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      zig = { "zigfmt" },
      go = { "gofmt", "goimports" },
      php = { "php_cs_fixer" },
      asm = { "astyle" },
      s = { "astyle" },
      sql = { "sql_formatter" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters = {
      prettierd = {
        env = {
          PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/.prettierrc.json"),
        },
        args = function()
          local sw = tostring(vim.bo.shiftwidth) -- Use bo (buffer-local) for current file
          return { "$FILENAME", "--tab-width", sw, "--use-tabs", "false" }
        end,
      },
      stylua = {
        args = function()
          local sw = tostring(vim.bo.shiftwidth)
          return { "--indent-width", sw, "-" }
        end,
      },
      black = {
        prepend_args = { "--line-length", "88" },
      },
      php_cs_fixer = {
        prepend_args = { "--using-cache=no" },
      },
    },
  },
}
