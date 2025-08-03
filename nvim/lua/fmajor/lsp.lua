-- LSP ZERO

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = "yes"

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require("lspconfig").util.default_config
-- lspconfig_defaults.capabilities = vim.tbl_deep_extend(
--   'force',
--   lspconfig_defaults.capabilities,
--   require('cmp_nvim_lsp').default_capabilities()
--   )

local telescope_builtin = require("telescope.builtin")

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, opts)
		-- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		-- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
		vim.keymap.set("n", "gi", telescope_builtin.lsp_implementations, opts)
		-- vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		vim.keymap.set("n", "go", telescope_builtin.lsp_type_definitions, opts)
		-- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
		vim.keymap.set("n", "gr", telescope_builtin.lsp_references, opts)
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
		vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	end,
})

vim.diagnostic.config({
	virtual_text = {
		severity = {
			min = vim.diagnostic.severity.INFO,
		},
		spacing = 2,
		prefix = "●",
	},
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").pyright.setup({
	capabilities = capabilities,
})
require("lspconfig").lua_ls.setup({
	capabilities = capabilities,
})
require("lspconfig").bashls.setup({
	capabilities = capabilities,
})
require("lspconfig").ts_ls.setup({
	capabilities = capabilities,
})
-- require('lspconfig').jdtls.setup({})
