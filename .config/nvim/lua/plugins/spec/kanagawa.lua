return {
  "rebelot/kanagawa.nvim",
  lazy = false,    -- Load this immediately
  priority = 1000, -- Make sure it loads before other plugins
  config = function()
    -- Default options
    require("kanagawa").setup({
      compile = false,  -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,     -- set background color
      dimInactive = false,    -- dim inactive window `:h hl-NormalNC`
      terminalColors = true,  -- define vim.g.terminal_color_{0..15}
      colors = {               -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors) -- add/modify highlights
        return {}
      end,
      theme = "wave",          -- Load "wave" theme (options: wave, dragon, lotus)
      background = {           -- map the value of 'background' option to a theme
        dark = "dragon",         -- try "dragon" for a darker theme
        light = "lotus"
      },
    })

    -- Actually load the colorscheme
    vim.cmd("colorscheme kanagawa")
  end,
}
