local function save_and_exit()
    vim.cmd("w")
    vim.cmd("Ex")
end

vim.api.nvim_create_user_command("W", save_and_exit, { nargs = 0 })
