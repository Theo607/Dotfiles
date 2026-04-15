return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    chunk = {
      enable = true,
      use_treesitter = false,
    },
    indent = {
      enable = true,
    },
    line_num = {
      enable = true,     -- turn on line numbers for indent levels
    },
    blank = {
      enable = false,
    },
  },
}

