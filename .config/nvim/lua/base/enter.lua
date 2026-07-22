local M = {}

function M.open_dashboard()
    
          local buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
          vim.api.nvim_set_option_value("filetype", "dashboard", { buf = buf })

          vim.api.nvim_win_set_buf(0, buf)

          vim.opt_local.cursorline     = false
          vim.opt_local.number         = false
          vim.opt_local.relativenumber = false

          local config_path = vim.fn.stdpath("config")
          local file_path = config_path .. "/lua/util/simple.txt"
          local lines = {}
          local file = io.open(file_path, "r")

          local content = {
              "",
              "Something went wrong.",
              "",
          }

          if file then
              for line in file:lines() do
                  table.insert(lines, line)
              end
              file:close()
              content = lines
          end

          local date = os.date("%A, %B %d, %Y")

          table.insert(content, date)

          local options = {
              "",
              " r – recent files",
              "f – find   file",
              "n – new    file",
          }

          for _, opt in ipairs(options) do
              table.insert(content, opt)
          end

          local win_width  = vim.api.nvim_win_get_width(0)
          local win_height = vim.api.nvim_win_get_height(0)

          local content_height = #content
          local top_padding = math.max(0, math.floor((win_height - content_height) / 2))
          
          local final_lines = {}

          for _ = 1, top_padding do
              table.insert(final_lines, "")
          end

          for _, line in ipairs(content) do
              local line_len = vim.fn.strdisplaywidth(line)
              local left_padding = math.max(0, math.floor((win_width - line_len) / 2))

              local centered_line = string.rep(" ", left_padding) .. line
              table.insert(final_lines, centered_line)
          end

          local opts = { silent = true, buffer = buf }

          -- 1. React to 'r' (Recent Files via Telescope)
          vim.keymap.set("n", "r", function()
            require("telescope.builtin").oldfiles()
          end, opts)

          -- 2. React to 'f' (Find Files via Telescope)
          vim.keymap.set("n", "f", function()
            require("telescope.builtin").find_files()
          end, opts)

          -- 3. React to 'n' (Open a fresh, empty text file layout)
          vim.keymap.set("n", "n", function()
              vim.cmd("enew")
          end, opts)



          vim.api.nvim_buf_set_lines(buf, 0, -1, false, final_lines)
          vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

end

function M.run() 
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == "" then
            M.open_dashboard()
        end
      end,
    })
end

return M

