-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    {
        'rose-pine/neovim',
        as = 'rose-pine',
    },
    {'devsjc/vim-jb'},
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    {'nvim-lua/plenary.nvim'}, -- don't forget to add this one if you don't have it yet!
    {'mbbill/undotree'},
    {
      'nvim-telescope/telescope-frecency.nvim',
      -- install the latest stable version
      version = "*",
      config = function()
        require("telescope").load_extension "frecency"
      end,
    },
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'catppuccin/nvim', name = "catppuccin", priority = 1000 },
    {
        'mikavilpas/yazi.nvim',
        event = "VeryLazy",
        ---@type YaziConfig
        opts = {
            open_for_directories = true,
            keymaps = {
                show_help = '<f1>',
            },
        },
    },
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {
        'folke/lazydev.nvim',
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
})
