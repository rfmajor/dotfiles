-- LSP ZERO

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = "yes"

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
lspconfig_defaults.capabilities =
	vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

local telescope_builtin = require("telescope.builtin")

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, opts)
		-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", telescope_builtin.lsp_implementations, opts)
		-- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
		-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gr", telescope_builtin.lsp_references, opts)
		vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<A-Enter>", function()
			vim.lsp.buf.code_action({
				apply = false,
			})
		end, opts)
		vim.keymap.set("n", "<leader>of", vim.diagnostic.open_float, opts)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client ~= nil then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})

vim.diagnostic.config({
	virtual_text = {
		severity = {
			min = vim.diagnostic.severity.HINT,
		},
		spacing = 2,
		prefix = "●",
	},
	float = {
		border = "rounded",
		source = "if_many",
	},
	signs = false,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
})

local red = "#fa6675"
local yellow = "#f2c55c"
local blue = "#5ccff2"
local purple = "#d95cf2"
local green = "#42fa0a"

vim.api.nvim_set_hl(0, "DiagnosticError", { fg = red, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = yellow, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = blue, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = purple, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticOk", { fg = green, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { fg = red, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { fg = yellow, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { fg = blue, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { fg = purple, italic = true })
vim.api.nvim_set_hl(0, "DiagnosticFloatingOk", { fg = green, italic = true })

--vim.lsp.config("pyright", {
--})
--vim.lsp.config("lua_ls", {
--})
--vim.lsp.config("bashls", {
--})
--vim.lsp.config("ts_ls", {
--})
--vim.lsp.config("postgres_lsp", {
--})
--vim.lsp.config("terraformls", {
--})
--vim.lsp.config("marksman", {
--})
--vim.lsp.config("clangd", {
--})
vim.lsp.enable("pyright")
vim.lsp.enable("lua_ls")
vim.lsp.enable("bashls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("postgres_lsp")
vim.lsp.enable("terraformls")
vim.lsp.enable("marksman")
vim.lsp.enable("clangd")
