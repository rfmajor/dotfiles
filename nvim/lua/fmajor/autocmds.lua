-- removes trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Set indentation to 2 spaces for specific filetypes
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = { '*.css', '*.html', '*.js', '*.mjs', '*.cjs', '*.ts', '*.scss', '*.xml', '*.xhtml' },
    command = 'setlocal shiftwidth=2 tabstop=2'
})
