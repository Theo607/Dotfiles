local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('clangd', {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  root_markers = {
    'compile_commands.json',
    'compile_flags.txt',
    '.git',
  },
  capabilities = capabilities,
})

vim.lsp.enable('clangd')
