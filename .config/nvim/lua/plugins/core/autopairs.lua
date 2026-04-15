return {
    "windwp/nvim-autopairs",
    event = "InsertEnter", 
    opts = {
        check_ts = true,
        ts_config = {
            lua = { "string" }, 
            javascript = { "template_string" },
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel", "oil" },
        fast_wrap = {
            map = "<M-e>", 
            chars = { "{", "[", "(", '"', "'" },
            pattern = [=[[%'%"%)%>%]%]%}%,]]=],
            offset = 0, 
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
        },
    },
    config = function(_, opts)
        local npairs = require("nvim-autopairs")
        npairs.setup(opts)

        local ok, cmp = pcall(require, "cmp")
        if ok then
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
    end,
}
