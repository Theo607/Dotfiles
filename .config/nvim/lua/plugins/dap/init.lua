return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
        require("plugins.dap.adapters")
        require("plugins.dap.ui")
        require("plugins.dap.keymaps")
        require("plugins.dap.virtual_text")
    end,
}
