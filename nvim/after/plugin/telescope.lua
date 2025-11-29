local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", function()
	builtin.find_files({ hidden = true })
end)

vim.keymap.set("n", "<leader>pj", function()
	builtin.buffers({ hidden = true })
end)

vim.keymap.set("n", "<leader>ls", function()
	builtin.live_grep({})
end)

-- put the highlighted text into the search buffer
vim.keymap.set("x", "<leader>ls", '"zy:Telescope live_grep default_text=<C-r>z<cr>')

vim.keymap.set("n", "<C-e>", ":Telescope frecency workspace=CWD theme=ivy<CR>")

require("telescope").setup({
	defaults = {},
	pickers = {
		find_files = {
            find_command = {
                "fd", ".", "--ignore-file", "$HOME/dotfiles/.fdignore", "-u", "--follow",
            },
			theme = "ivy",
            hidden = true,
            no_ignore = false,
            no_ignore_parent = false
		},
		live_grep = {
			additional_args = { "--ignore-file=$HOME/dotfiles/.rgignore" },
		},
	},
	extensions = {},
})
