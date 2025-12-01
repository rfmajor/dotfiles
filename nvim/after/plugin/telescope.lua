local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", function()
	builtin.find_files({ hidden = true })
end)

vim.keymap.set("n", "<leader>pj", function()
	builtin.buffers({ hidden = true })
end)

vim.keymap.set("n", "<leader>ls", function()
	builtin.live_grep({ hidden = true })
end)

vim.keymap.set("n", "<leader>ps", function()
    local searchQuery = vim.fn.input("> ")
    if searchQuery ~= "" then
        builtin.grep_string({ hidden = true, search = searchQuery })
    else
        print("No input")
    end
end)

-- put the highlighted text into the search buffer
vim.keymap.set("x", "<leader>ls", '"zy:Telescope live_grep default_text=<C-r>z<cr>')
vim.keymap.set("x", "<leader>pf", '"zy:Telescope find_files default_text=<C-r>z<cr>')
vim.keymap.set("x", "<leader>ps", '"zy:Telescope grep_string search=<C-r>z<cr>')

vim.keymap.set("n", "<C-e>", ":Telescope frecency workspace=CWD theme=ivy<CR>")

local rgIgnorePath = vim.fn.expand("$HOME/dotfiles/.rgignore")
local fdIgnorePath = vim.fn.expand("$HOME/dotfiles/.fdignore")
require("telescope").setup({
	defaults = {},
	pickers = {
		find_files = {
            find_command = {
                "fd", ".", "--ignore-file", rgIgnorePath, "-u", "--follow",
            },
			theme = "ivy",
            hidden = true,
            no_ignore = false,
            no_ignore_parent = false
		},
		live_grep = {
			additional_args = { "--ignore-file=" .. fdIgnorePath },
		},
	},
	extensions = {},
})
