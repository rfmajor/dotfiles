local conform = require("conform")
vim.g.format_on_save = true
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
	default_format_opts = {
		lsp_format = "never",
	},
	format_on_save = function()
		if vim.g.format_on_save then
			return {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		else
			return nil
		end
	end,
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

local function conform_toggle()
	vim.g.format_on_save = not vim.g.format_on_save
	if vim.g.format_on_save then
		print("Format on save is on")
	else
		print("Format on save is off")
	end
end

vim.api.nvim_create_user_command("ConformSaveToggle", conform_toggle, {})
