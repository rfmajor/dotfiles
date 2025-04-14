local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', function()
    builtin.find_files({ hidden = true })
end)

vim.keymap.set('n', '<leader>pj', function()
    builtin.buffers({ hidden = true })
end)

vim.keymap.set('n', '<leader>ls', builtin.live_grep, {})

-- put the highlighted text into the search buffer
vim.keymap.set('x', '<leader>ls', '\"zy:Telescope live_grep default_text=<C-r>z<cr>')

vim.keymap.set('n', '<C-e>', ":Telescope frecency workspace=CWD theme=ivy<CR>")

require('telescope').setup {
    defaults = {
    },
    pickers = {
        find_files = {
            theme = "ivy",
        }
    },
    extensions = {
    }
}
