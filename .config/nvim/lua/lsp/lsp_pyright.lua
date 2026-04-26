vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git',
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly', -- 'workspace' for full project linting
        typeCheckingMode = 'basic',      -- can be 'off', 'basic', or 'strict'
      },
    },
  },
})

vim.lsp.enable('pyright')
