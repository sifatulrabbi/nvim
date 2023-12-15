vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        if vim.fn.isdirectory(vim.fn.getcwd()) == 1 and #vim.fn.argv() == 1 then
            vim.cmd("Neotree<CR>")
        end
    end,
})

vim.api.nvim_create_autocmd("WinEnter", {
    callback = function()
        local buf_name = vim.api.nvim_buf_get_name(0)
        if string.find(buf_name, "neo%-tree") then
            return
        end

        vim.wo.nu = true
        vim.wo.relativenumber = true
    end,
})
