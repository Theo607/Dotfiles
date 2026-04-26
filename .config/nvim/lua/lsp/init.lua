vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)         
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)        
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)     
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)         
    
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)               
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)  

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)     
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts) 
    
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts) 
  end,
})

require("lsp.lsp_luals")
require("lsp.lsp_clangd")
require("lsp.lsp_rust-analyzer")
require("lsp.lsp_pyright")
require("lsp.lsp_tinymist")
