-- For help `:help Git`
vim.keymap.set('n', '<leader>gf', function() vim.cmd('Git') end, { desc = 'Open git fugitive' })
