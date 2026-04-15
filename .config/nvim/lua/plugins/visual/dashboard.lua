return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            [[      ___           ___           ___       ]],
            [[     /\  \         /\__\         /\  \      ]],
            [[    /::\  \       /:/ _/_       /::\  \     ]],
            [[   /:/\:\  \     /:/ /\__\     /:/\:\  \    ]],
            [[  /:/  \:\  \   /:/ /:/ _/_   /:/  \:\  \   ]],
            [[ /:/__/ \:\__\ /:/_/:/ /\__\ /:/__/ \:\__\  ]],
            [[ \:\  \  \/__/ \:\/:/ /:/  / \:\  \ /:/  /  ]],
            [[  \:\  \        \::/_/:/  /   \:\  /:/  /   ]],
            [[   \:\  \        \:\/:/  /     \:\/:/  /    ]],
            [[    \:\__\        \::/  /       \::/  /     ]],
            [[     \/__/         \/__/         \/__/      ]],
            [[                                            ]],
            [[            [ 👾 SYSTEM READY ]             ]],
        }
        dashboard.section.header.opts.hl = "GruvboxOrange"

        -- 2. Buttons with Gruvbox Icons
        dashboard.section.buttons.val = {
            dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
            dashboard.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
            dashboard.button("r", "  Recent Files", ":Telescope oldfiles <CR>"),
            dashboard.button("g", "󰈭  Live Grep", ":Telescope live_grep <CR>"),
            dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
            dashboard.button("u", "󰚰  Update Plugins", ":Lazy sync<CR>"),
            dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
        }

        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "GruvboxGreen"
            button.opts.hl_shortcut = "GruvboxRed"
        end

        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "󱐌 " .. stats.count .. " plugins loaded in " .. ms .. "ms"
        dashboard.section.footer.opts.hl = "GruvboxGray"

        dashboard.opts.layout[1].val = 8
        
        vim.api.nvim_set_hl(0, "AlphaHeader", { link = "GruvboxOrange" })
        
        alpha.setup(dashboard.config)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "alpha",
            callback = function()
                vim.opt_local.laststatus = 0
            end,
        })
        vim.api.nvim_create_autocmd("BufUnload", {
            buffer = 0,
            callback = function()
                vim.opt.laststatus = 3
            end,
        })
    end,
}
