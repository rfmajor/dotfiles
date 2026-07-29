-- removes trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

-- Set indentation to 2 spaces for specific filetypes
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.css", "*.html", "*.js", "*.mjs", "*.cjs", "*.ts", "*.scss", "*.xml", "*.xhtml", "*.bru" },
	command = "setlocal shiftwidth=2 tabstop=2",
})

local lang_to_cmd = {}
lang_to_cmd["*.c"] = ":!gcc % && ./a.out<CR>"
lang_to_cmd["*.py"] = ":!python %<CR>"
lang_to_cmd["*.lua"] = ":!lua %<CR>"
lang_to_cmd["*.bru"] =
	':!abs=$(readlink -f %); cd $(git rev-parse --show-toplevel)/tests/functional; bru run "$abs" --env localhost<CR>'
lang_to_cmd["*.sh"] = ":!sh -c ./%<CR>"

for key, value in pairs(lang_to_cmd) do
	vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
		desc = "Compile/execute a standalone file",
		pattern = { key },
		callback = function()
			vim.keymap.set("n", "<leader>e", value)
		end,
	})
end

vim.filetype.add({
	pattern = {
		[".*/*.bru"] = "json",
	},
})
