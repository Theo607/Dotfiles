return {
  "equalsraf/vim-win32yank",
  build = "cargo build --release", -- optional if using prebuilt binaries
  config = function()
    vim.g.clipboard = {
      name = "win32yank",
      copy = { ["+"] = "win32yank.exe -i --crlf", ["*"] = "win32yank.exe -i --crlf" },
      paste = { ["+"] = "win32yank.exe -o --lf", ["*"] = "win32yank.exe -o --lf" },
      cache_enabled = 0,
    }
  end,
}

