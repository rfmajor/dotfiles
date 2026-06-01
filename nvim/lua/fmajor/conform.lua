local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		python = { "black" },
		go = { "gofmt" },
		json = { "prettier" },
		yaml = { "prettier" },
		html = { "prettier" },
		markdown = { "prettier" },
		bash = { "shellcheck" },
		sh = { "shfmt" },
        c = { "clang-format" }
	},
})
conform.formatters.prettier = {
    append_args = { "--config", os.getenv("HOME") .. "/dotfiles/.prettierrc.json" }
}

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

    conform.format(opts)
end, { desc = "Format selection or whole file" })

