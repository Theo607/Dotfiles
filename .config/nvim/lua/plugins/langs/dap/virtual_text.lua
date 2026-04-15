return {
  "theHamsta/nvim-dap-virtual-text",
  dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = true,
      show_stop_reason = true,
      commented = false,
      virt_text_pos = "eol",
      all_frames = false,
      -- This helps distinguish virtual text from actual code
      virt_text_win_col = nil, -- Displayed at the end of the line
    })

    -- Optional: Make virtual text slightly dimmed to match Gruvbox aesthetics
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
    vim.api.nvim_set_hl(0, "NvimDapVirtualText", { fg = "#928374", italic = true })
  end,
}
