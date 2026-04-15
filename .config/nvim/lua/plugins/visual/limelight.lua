return {
  "junegunn/limelight.vim",
  event = "BufReadPre",
  config = function()
    -- Optional: adjust dimming
    vim.g.limelight_paragraph_span = 1          -- highlight current + 1 paragraph
    vim.g.limelight_conceal_ctermfg = 240      -- terminal dim color
    vim.g.limelight_conceal_guifg = "#555555"  -- GUI dim color

    -- Manual toggle state
    local enabled = false

    -- Create a toggle command
    vim.api.nvim_create_user_command("ToggleLimelight", function()
      if enabled then
        vim.cmd("Limelight!")  -- turn off
        enabled = false
      else
        vim.cmd("Limelight")               -- turn on
        enabled = true
      end
    end, {})

    -- Keymap to toggle Limelight
    vim.keymap.set("n", "<leader>z", ":ToggleLimelight<CR>", { silent = true })
  end,
}

