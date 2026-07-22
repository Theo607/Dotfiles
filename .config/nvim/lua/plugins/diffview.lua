return 
{
    "sindrets/diffview.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
        { "<leader>vd", "<cmd>DiffviewOpen<cr>", desc = "View Diffview Open" },
        { "<leader>vx", "<cmd>DiffviewClose<cr>", desc = "View Diffview Close" },
        { "<leader>vh", "<cmd>DiffviewFileHistory %<cr>", desc = "View File History" },
    },
    opts = {}
}
