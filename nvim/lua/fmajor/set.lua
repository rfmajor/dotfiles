-- Fat cursor
vim.opt.guicursor = ""

-- numbers and relative numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- 4 space tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- indenting
vim.opt.smartindent = true

-- no line wrapping
vim.opt.wrap = false

-- don't make backups or swapfiles
vim.opt.swapfile = false
vim.opt.backup = false
-- save history to an undofile
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- configure incremental search
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- keep 8 lines of margin when scrolling
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- case insensitive search
vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "
