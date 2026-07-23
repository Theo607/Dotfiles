-- Dynamically generated colorscheme inspired by Hex Lavender
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "dynamic"
vim.o.background = "dark"

local palette = {
  bg = "#1b211c",
  bg_dark = "#283029",
  bg_highlight = "#283029",
  bg_selection = "#3a473c",
  
  fg = "#c5d6c7",
  fg_dark = "#6c8470",
  fg_gutter = "#6c8470",
  comment = "#6c8470",

  accent = "#d1c979",
  accent2 = "#8ccc7e",
  red = "#d16c78",
  green = "#7bc682",
  yellow = "#d1b879",
  blue = "#81a1d1",
  magenta = "#b479d1",
  cyan = "#7ecccc",
  white = "#ffffff",
}

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Core Editor UI
hl("Normal", { fg = palette.fg, bg = palette.bg })
hl("NormalFloat", { fg = palette.fg, bg = palette.bg_dark })
hl("FloatBorder", { fg = palette.accent, bg = palette.bg_dark })
hl("ColorColumn", { bg = palette.bg_highlight })
hl("Cursor", { fg = palette.bg, bg = palette.accent })
hl("CursorLine", { bg = palette.bg_highlight })
hl("CursorColumn", { bg = palette.bg_highlight })
hl("Directory", { fg = palette.blue, bold = true })
hl("ErrorMsg", { fg = palette.red, bold = true })
hl("WarningMsg", { fg = palette.yellow })
hl("WinSeparator", { fg = palette.bg_selection, bg = "NONE" })
hl("VertSplit", { fg = palette.bg_selection, bg = "NONE" })
hl("LineNr", { fg = palette.fg_gutter })
hl("CursorLineNr", { fg = palette.accent, bold = true })
hl("MatchParen", { fg = palette.white, bg = palette.bg_selection, bold = true })
hl("Pmenu", { fg = palette.fg, bg = palette.bg_dark })
hl("PmenuSel", { fg = palette.white, bg = palette.bg_selection, bold = true })
hl("PmenuSbar", { bg = palette.bg_highlight })
hl("PmenuThumb", { bg = palette.accent })
hl("StatusLine", { fg = palette.fg, bg = palette.bg_dark })
hl("StatusLineNC", { fg = palette.comment, bg = palette.bg_dark })
hl("TabLine", { fg = palette.comment, bg = palette.bg_dark })
hl("TabLineSel", { fg = palette.fg, bg = palette.bg_highlight, bold = true })
hl("Visual", { bg = palette.bg_selection })
hl("Search", { fg = palette.bg, bg = palette.accent, bold = true })
hl("IncSearch", { fg = palette.bg, bg = palette.magenta, bold = true })

-- Balanced Syntax Highlighting (Hex Lavender Style)
hl("Comment", { fg = palette.comment, italic = true })
hl("Constant", { fg = palette.magenta })
hl("String", { fg = palette.green, italic = true })
hl("Character", { fg = palette.green })
hl("Number", { fg = palette.yellow })
hl("Boolean", { fg = palette.accent, bold = true })
hl("Float", { fg = palette.yellow })
hl("Identifier", { fg = palette.fg })
hl("Function", { fg = palette.cyan })
hl("Statement", { fg = palette.blue })
hl("Conditional", { fg = palette.blue })
hl("Repeat", { fg = palette.blue })
hl("Label", { fg = palette.cyan })
hl("Operator", { fg = palette.accent2 })
hl("Keyword", { fg = palette.magenta, italic = true })
hl("Exception", { fg = palette.red })
hl("PreProc", { fg = palette.accent2 })
hl("Include", { fg = palette.accent })
hl("Define", { fg = palette.accent2 })
hl("Macro", { fg = palette.accent2 })
hl("Type", { fg = palette.accent, bold = true })
hl("StorageClass", { fg = palette.accent })
hl("Structure", { fg = palette.accent })
hl("Typedef", { fg = palette.accent })
hl("Special", { fg = palette.magenta })
hl("SpecialChar", { fg = palette.magenta })
hl("Delimiter", { fg = palette.fg_dark })
hl("SpecialComment", { fg = palette.accent, bold = true })
hl("Error", { fg = palette.red, bold = true })
hl("Todo", { fg = palette.bg, bg = palette.accent, bold = true })

-- Diagnostics
hl("DiagnosticError", { fg = palette.red })
hl("DiagnosticWarn", { fg = palette.yellow })
hl("DiagnosticInfo", { fg = palette.blue })
hl("DiagnosticHint", { fg = palette.cyan })
hl("DiagnosticUnderlineError", { undercurl = true, sp = palette.red })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = palette.yellow })
hl("DiagnosticUnderlineInfo", { undercurl = true, sp = palette.blue })
hl("DiagnosticUnderlineHint", { undercurl = true, sp = palette.cyan })

-- TreeSitter Links
hl("@comment", { link = "Comment" })
hl("@keyword", { link = "Keyword" })
hl("@function", { link = "Function" })
hl("@function.builtin", { fg = palette.cyan, italic = true })
hl("@variable", { fg = palette.fg })
hl("@variable.builtin", { fg = palette.accent, italic = true })
hl("@variable.parameter", { fg = palette.fg_dark, italic = true })
hl("@property", { fg = palette.fg_dark })
hl("@type", { link = "Type" })
hl("@type.builtin", { fg = palette.accent, italic = true })
hl("@string", { link = "String" })
hl("@number", { link = "Number" })
hl("@boolean", { link = "Boolean" })
hl("@operator", { link = "Operator" })
hl("@punctuation.delimiter", { fg = palette.fg_dark })
hl("@punctuation.bracket", { fg = palette.fg })

-- GitSigns
hl("GitSignsAdd", { fg = palette.green })
hl("GitSignsChange", { fg = palette.yellow })
hl("GitSignsDelete", { fg = palette.red })

-- Telescope
hl("TelescopeBorder", { fg = palette.accent, bg = palette.bg_dark })
hl("TelescopePromptBorder", { fg = palette.accent, bg = palette.bg_highlight })
hl("TelescopePromptNormal", { fg = palette.fg, bg = palette.bg_highlight })
hl("TelescopePromptTitle", { fg = palette.bg, bg = palette.accent, bold = true })
hl("TelescopePreviewTitle", { fg = palette.bg, bg = palette.green, bold = true })
hl("TelescopeResultsTitle", { fg = palette.bg, bg = palette.blue, bold = true })
hl("TelescopeSelection", { bg = palette.bg_selection, fg = palette.white })

-- WhichKey
hl("WhichKey", { fg = palette.accent, bold = true })
hl("WhichKeyGroup", { fg = palette.blue })
hl("WhichKeyDesc", { fg = palette.fg })

-- Refresh lualine dynamically if running inside Neovim
pcall(function()
  require("lualine").setup({ options = { theme = "auto" } })
end)
