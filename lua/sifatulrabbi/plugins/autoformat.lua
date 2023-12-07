return {
    'neovim/nvim-lspconfig',
    config = function()
        -- Switch for controlling whether you want autoformatting.
        --  Use :KickstartFormatToggle to toggle autoformatting on or off
        local format_is_enabled = true
        vim.api.nvim_create_user_command('KickstartFormatToggle', function()
            format_is_enabled = not format_is_enabled
            print('Setting autoformatting to: ' .. tostring(format_is_enabled))
        end, {})

        -- Create an augroup that is used for managing our formatting autocmds.
        --      We need one augroup per client to make sure that multiple clients
        --      can attach to the same buffer without interfering with each other.
        local _augroups = {}
        local get_augroup = function(client)
            if not _augroups[client.id] then
                local group_name = 'kickstart-lsp-format-' .. client.name
                local id = vim.api.nvim_create_augroup(group_name, { clear = true })
                _augroups[client.id] = id
            end

            return _augroups[client.id]
        end

        local function should_use_prettier()
            local filetypes = {
                'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css', 'scss', 'less', 'json', 'yaml',
                'markdown', 'html', 'vue',
            }
            local filetype = vim.bo.filetype
            return vim.tbl_contains(filetypes, filetype)
        end

        local function format_with_prettier(bufnr)
            local filename = vim.api.nvim_buf_get_name(bufnr)
            local prettier_cmd = 'prettier --write ' .. vim.fn.shellescape(filename)

            vim.fn.jobstart(prettier_cmd, {
                on_exit = function(job_id, exit_code, event_type)
                    if exit_code == 0 then
                        vim.api.nvim_buf_call(bufnr, function() vim.cmd('e!') end)
                    else
                        print('Prettier failed to format the file.')
                    end
                end,
            })
        end

        -- local function should_use_black_formatter()
        --     local filenames = { 'python' }
        --     local filetype = vim.bo.filetype
        --     print(filetype)
        --     return vim.tbl_contains(filenames, filetype)
        -- end
        --
        -- local function format_with_black(bufnr)
        --     local filename = vim.api.nvim_buf_get_name(bufnr)
        --     local cmd = 'black ' .. vim.fn.shellescape(filename)
        --
        --     vim.fn.jobstart(cmd, {
        --         on_exit = function(job_id, exit_code, event_type)
        --             if exit_code == 0 then
        --                 vim.api.nvim_buf_call(bufnr, function() vim.cmd('e!') end)
        --             else
        --                 print('Black failed to format the file.')
        --             end
        --         end
        --     })
        -- end

        -- See `:help LspAttach` for more information about this autocmd event.
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
            callback = function(args)
                local client_id = args.data.client_id
                local client = vim.lsp.get_client_by_id(client_id)
                local bufnr = args.buf

                -- Only attach to clients that support document formatting
                if not client.server_capabilities.documentFormattingProvider then
                    return
                end

                -- Create an autocmd that will run *before* we save the buffer.
                --  Run the formatting command for the LSP that has just attached.
                vim.api.nvim_create_autocmd('BufWritePre', {
                    group = get_augroup(client),
                    buffer = bufnr,
                    callback = function()
                        if not format_is_enabled then
                            return
                        end

                        -- for prettier supported files do not use the vim's default lsp formatter
                        if should_use_prettier() then
                            format_with_prettier(bufnr)
                            return
                        end

                        -- if should_use_black_formatter() then
                        --     print('formatting with black')
                        --     format_with_black(bufnr)
                        --     return
                        -- end

                        -- for rest of the files use the built in formatter
                        vim.lsp.buf.format {
                            async = false,
                            filter = function(c)
                                return c.id == client.id
                            end,
                        }
                    end,
                })
            end
            ,
        })
    end,
}
