return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    chunk = {
      enable = true,
      use_treesitter = true, 
      style = {
        { fg = "#fabd2f" }, 
      },
    },
    indent = {
      enable = true,
      use_treesitter = true,
      style = { "#3c3836" }, 
    },
    line_num = {
      enable = true,
      style = "#fabd2f", 
    },
    blank = {
      enable = false,
    },
  },
}
