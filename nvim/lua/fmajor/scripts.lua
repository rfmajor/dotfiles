local function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

vim.keymap.set('n', '<leader>t', function()
    local filetype = vim.bo.filetype
    local templates_dir = vim.fn.expand('$HOME/dotfiles/templates')
    local template_name = string.format("%s/template.%s", templates_dir, filetype)
    if file_exists(template_name) then
        vim.cmd(string.format(":r %s", template_name))
    end
end)

vim.keymap.set({ "n", "v" }, "<leader>f", function()
    local mode = vim.fn.mode()

    local opts = {
        async = true,
        lsp_fallback = true,
    }

    -- If in visual mode, calculate selected range
    if mode == "v" or mode == "V" or mode == "\22" then
        local start_pos = vim.api.nvim_buf_get_mark(0, "<") -- start of selection
        local end_pos = vim.api.nvim_buf_get_mark(0, ">")   -- end of selection

        opts.range = {
            start = { start_pos[1], start_pos[2] },
            ["end"] = { end_pos[1], end_pos[2] },
        }
    end

    require("conform").format(opts)
end, { desc = "Format selection or whole file" })
