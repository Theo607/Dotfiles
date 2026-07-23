-- Hex Lavender colorscheme for Neovim (Deep Dark Variant)

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "hex-lavender"
vim.o.background = "dark"

local palette = {
  bg = "#0f0d17",
  bg_dark = "#0a0812",
  bg_highlight = "#1c172b",
  bg_selection = "#32274d",
  
  fg = "#e6e6fa",
  fg_dark = "#b4befe",
  fg_gutter = "#585b70",
  comment = "#7970a0",

  lavender = "#c4b5fd",
  lavender_bright = "#ddb6f2",
  pink = "#f5c2e7",
  red = "#f38ba8",
  peach = "#fab387",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  teal = "#94e2d5",
  cyan = "#89dceb",
  blue = "#89b4fa",
  white = "#ffffff",
}

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Core Editor
hl("Normal", { fg = palette.fg, bg = palette.bg })
hl("NormalFloat", { fg = palette.fg, bg = palette.bg_dark })
hl("FloatBorder", { fg = palette.lavender, bg = palette.bg_dark })
hl("ColorColumn", { bg = palette.bg_highlight })
hl("Cursor", { fg = palette.bg, bg = palette.lavender })
hl("CursorLine", { bg = palette.bg_highlight })
hl("CursorColumn", { bg = palette.bg_highlight })
hl("Directory", { fg = palette.blue, bold = true })
hl("DiffAdd", { fg = palette.green, bg = "#182b20" })
hl("DiffChange", { fg = palette.yellow, bg = "#2b2518" })
hl("DiffDelete", { fg = palette.red, bg = "#2e1623" })
hl("DiffText", { fg = palette.cyan, bg = "#1a303b" })
hl("ErrorMsg", { fg = palette.red, bold = true })
hl("WarningMsg", { fg = palette.yellow })
hl("WinSeparator", { fg = palette.bg_selection, bg = "NONE" })
hl("VertSplit", { fg = palette.bg_selection, bg = "NONE" })
hl("Folded", { fg = palette.comment, bg = palette.bg_highlight })
hl("FoldColumn", { fg = palette.comment, bg = palette.bg })
hl("SignColumn", { fg = palette.fg, bg = palette.bg })
hl("LineNr", { fg = palette.fg_gutter })
hl("CursorLineNr", { fg = palette.lavender, bold = true })
hl("MatchParen", { fg = palette.white, bg = "#48366a", bold = true })
hl("ModeMsg", { fg = palette.green, bold = true })
hl("MoreMsg", { fg = palette.blue })
hl("NonText", { fg = palette.fg_gutter })
hl("Pmenu", { fg = palette.fg, bg = palette.bg_dark })
hl("PmenuSel", { fg = palette.white, bg = palette.bg_selection, bold = true })
hl("PmenuSbar", { bg = palette.bg_highlight })
hl("PmenuThumb", { bg = palette.lavender })
hl("Question", { fg = palette.blue })
hl("Search", { fg = palette.bg, bg = palette.lavender, bold = true })
hl("IncSearch", { fg = palette.bg, bg = palette.pink, bold = true })
hl("SpecialKey", { fg = palette.fg_gutter })
hl("StatusLine", { fg = palette.fg, bg = palette.bg_highlight })
hl("StatusLineNC", { fg = palette.comment, bg = palette.bg_dark })
hl("TabLine", { fg = palette.comment, bg = palette.bg_dark })
hl("TabLineFill", { bg = palette.bg_dark })
hl("TabLineSel", { fg = palette.fg, bg = palette.bg_highlight, bold = true })
hl("Title", { fg = palette.lavender, bold = true })
hl("Visual", { bg = palette.bg_selection })
hl("VisualNOS", { bg = palette.bg_selection })
hl("WildMenu", { fg = palette.bg, bg = palette.lavender })

-- Syntax Highlighting
hl("Comment", { fg = palette.comment, italic = true })
hl("Constant", { fg = palette.yellow })
hl("String", { fg = palette.green })
hl("Character", { fg = palette.green })
hl("Number", { fg = palette.peach })
hl("Boolean", { fg = palette.lavender_bright, bold = true })
hl("Float", { fg = palette.peach })
hl("Identifier", { fg = palette.fg })
hl("Function", { fg = palette.blue, bold = true })
hl("Statement", { fg = palette.lavender, bold = true })
hl("Conditional", { fg = palette.lavender, bold = true })
hl("Repeat", { fg = palette.lavender, bold = true })
hl("Label", { fg = palette.cyan })
hl("Operator", { fg = palette.teal })
hl("Keyword", { fg = palette.lavender, italic = true })
hl("Exception", { fg = palette.red, bold = true })
hl("PreProc", { fg = palette.lavender_bright })
hl("Include", { fg = palette.lavender })
hl("Define", { fg = palette.lavender_bright })
hl("Macro", { fg = palette.lavender_bright })
hl("PreCondit", { fg = palette.lavender_bright })
hl("Type", { fg = palette.cyan })
hl("StorageClass", { fg = palette.lavender })
hl("Structure", { fg = palette.cyan })
hl("Typedef", { fg = palette.cyan })
hl("Special", { fg = palette.pink })
hl("SpecialChar", { fg = palette.pink })
hl("Tag", { fg = palette.blue })
hl("Delimiter", { fg = palette.fg_dark })
hl("SpecialComment", { fg = palette.lavender, bold = true })
hl("Debug", { fg = palette.red })
hl("Underlined", { underline = true })
hl("Ignore", { fg = palette.fg_gutter })
hl("Error", { fg = palette.red, bold = true })
hl("Todo", { fg = palette.bg, bg = palette.lavender, bold = true })

-- Diagnostics
hl("DiagnosticError", { fg = palette.red })
hl("DiagnosticWarn", { fg = palette.yellow })
hl("DiagnosticInfo", { fg = palette.blue })
hl("DiagnosticHint", { fg = palette.teal })
hl("DiagnosticUnderlineError", { undercurl = true, sp = palette.red })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = palette.yellow })
hl("DiagnosticUnderlineInfo", { undercurl = true, sp = palette.blue })
hl("DiagnosticUnderlineHint", { undercurl = true, sp = palette.teal })

-- TreeSitter links & specifics
hl("@comment", { link = "Comment" })
hl("@keyword", { link = "Keyword" })
hl("@function", { link = "Function" })
hl("@function.builtin", { fg = palette.blue, italic = true })
hl("@variable", { fg = palette.fg })
hl("@variable.builtin", { fg = palette.lavender, italic = true })
hl("@variable.parameter", { fg = palette.fg, italic = true })
hl("@property", { fg = palette.fg_dark })
hl("@type", { link = "Type" })
hl("@type.builtin", { fg = palette.cyan, italic = true })
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
hl("TelescopeBorder", { fg = palette.lavender, bg = palette.bg_dark })
hl("TelescopePromptBorder", { fg = palette.lavender, bg = palette.bg_highlight })
hl("TelescopePromptNormal", { fg = palette.fg, bg = palette.bg_highlight })
hl("TelescopePromptTitle", { fg = palette.bg, bg = palette.lavender, bold = true })
hl("TelescopePreviewTitle", { fg = palette.bg, bg = palette.green, bold = true })
hl("TelescopeResultsTitle", { fg = palette.bg, bg = palette.blue, bold = true })
hl("TelescopeSelection", { bg = palette.bg_selection, fg = palette.white })

-- WhichKey
hl("WhichKey", { fg = palette.lavender, bold = true })
hl("WhichKeyGroup", { fg = palette.blue })
hl("WhichKeyDesc", { fg = palette.fg })
