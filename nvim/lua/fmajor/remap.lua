vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- moving the visually selected area 
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- append the next line without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")
-- keep the cursor in the middle of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste without overwriting the register
vim.keymap.set("x", "<leader>p", "\"_dP")
-- yank to the system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- delete to the void register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")
vim.keymap.set("n", "<leader>x", "\"_x")
vim.keymap.set("v", "<leader>x", "\"_x")
vim.keymap.set("n", "<leader>D", "\"_D")
vim.keymap.set("v", "<leader>D", "\"_D")

-- enclose the selected area and keep inner text selected (like in Intellij)
vim.keymap.set("x", "<leader>(", "<Esc>`<i(<Esc>`>la)<Esc>hv`<l")
vim.keymap.set("x", "<leader><", "<Esc>`<i<<Esc>`>la><Esc>hv`<l")
vim.keymap.set("x", "<leader>{", "<Esc>`<i{<Esc>`>la}<Esc>hv`<l")
vim.keymap.set("x", "<leader>[", "<Esc>`<i[<Esc>`>la]<Esc>hv`<l")
vim.keymap.set("x", "<leader>\"", "<Esc>`<i\"<Esc>`>la\"<Esc>hv`<l")
vim.keymap.set("x", "<leader>'", "<Esc>`<i'<Esc>`>la'<Esc>hv`<l")
vim.keymap.set("x", "<leader>`", "<Esc>`<i`<Esc>`>la`<Esc>hv`<l")

-- split the windows horizontally/vertically
vim.keymap.set("n", "<C-w>s", "<nop>")
vim.keymap.set("n", "<C-w>t", ":split<CR>")
vim.keymap.set("n", "<C-w>v", ":vsplit<CR>")

-- remove Q
vim.keymap.set("n", "Q", "<nop>")

-- horizontal scroll and centering
vim.keymap.set("n", "<C-l>", "40lzszH")
vim.keymap.set("n", "<C-h>", "40hzszH")
vim.keymap.set("n", "zZ", "zszH")

