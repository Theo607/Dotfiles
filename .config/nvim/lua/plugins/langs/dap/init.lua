return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
        require("plugins.langs.dap.adapters")
        require("plugins.langs.dap.ui")
        require("plugins.langs.dap.keymaps")
        require("plugins.langs.dap.virtual_text")
    end,
}
