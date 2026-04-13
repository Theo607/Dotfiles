return {
  "alvan/vim-closetag",
  event = "InsertEnter",
  config = function()
    vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.jsx,*.tsx"
    vim.g.closetag_xhtml_filenames = "*.xhtml,*.jsx,*.tsx"
    vim.g.closetag_filetypes = "html,xhtml,phtml,jsx,tsx"
    vim.g.closetag_emptyTags_caseSensitive = 1
    vim.g.closetag_shortcut = ">;," -- optional
  end,
}

