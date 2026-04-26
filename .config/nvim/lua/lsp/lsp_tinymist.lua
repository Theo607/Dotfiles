vim.lsp.config('tinymist', {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  root_markers = { 'main.typ', '.git' },
  settings = {
    exportPdf = "onSave", -- Options: "onSave", "onType", "never"
    semanticTokens = "enable",
  },
})

vim.lsp.enable('tinymist')
