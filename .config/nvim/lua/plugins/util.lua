return {
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      opts = {
        enable_close = true,          
        enable_rename = true,         
        enable_close_on_slash = true, 
      }
    }
  },
  {
    "kylechui/nvim-surround",
    version = "*", 
    event = "VeryLazy",
    opts = {}
  },
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },
  {
    'echasnovski/mini.ai',
    event = "VeryLazy",
    config = function()
      require('mini.ai').setup()
    end,
  },
  {
    'Eandrju/cellular-automaton.nvim',
    keys = { { '<leader>fml', '<CMD>CellularAutomaton make_it_rain<CR>', desc = 'Make it rain' } },
  },
}
