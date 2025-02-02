local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', function()
    builtin.find_files({ hidden = true })
end)
-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end) 
vim.keymap.set('n', '<leader>ls', builtin.live_grep, {})

-- put the highlighted text into the search buffer
vim.keymap.set('x', '<leader>ls', '\"zy:Telescope live_grep default_text=<C-r>z<cr>')
-- resume last search
vim.keymap.set('n', '<leader>rs', require('telescope.builtin').resume, {
    noremap = true,
    silent = true,
    desc = 'Resume',
})
