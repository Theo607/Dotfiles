vim.keymap.set('n', '<leader>q', ":quit<CR>")
vim.keymap.set('n', '<leader>Q', ":quit!<CR>")
vim.keymap.set('n', '<leader>w', ":write<CR>")
vim.keymap.set('n', '<leader>W', ":write!<CR>")
vim.keymap.set('n', '<leader>b', ":browse oldfiles<CR>")


local function yazi_picker()
    local tmp = os.tmpname()
    
    local cmd = string.format("yazi --chooser-file='%s'", tmp)
    
    vim.fn.termopen(cmd, {
        on_exit = function()
            local f = io.open(tmp, "r")
            if f then
                local file_path = f:read("*all")
                f:close()
                os.remove(tmp) 

                if file_path ~= "" then
                    vim.schedule(function()
                        vim.cmd("edit " .. file_path)
                    end)
                end
            end
        end
    })

    vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>y", yazi_picker, { desc = "Yazi File Picker" })
vim.keymap.set("n", "<leader>ct", ":NoNeckPain<CR>:NoNeckPainResize 80<CR>")
