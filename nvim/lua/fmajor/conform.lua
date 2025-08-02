require("conform").setup({
	format_on_save = {
		timeout_ms = 1000,
		lsp_fallback = true,
	},
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		python = { "black" },
		go = { "gofmt" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		bash = { "shellcheck" },
		sh = { "shfmt" },
	},
})
