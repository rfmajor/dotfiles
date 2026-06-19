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
		css = { "prettier" },
		markdown = { "prettier" },
		bash = { "shellcheck" },
		sh = { "shfmt" },
		c = { "clang-format" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
conform.formatters.prettier = {
	append_args = { "--config", os.getenv("HOME") .. "/dotfiles/.prettierrc.json" },
}

vim.keymap.set({ "n" }, "<leader>f", function()
	local opts = {
		async = true,
		lsp_fallback = true,
	}
	conform.format(opts)
end, { desc = "Format file" })
