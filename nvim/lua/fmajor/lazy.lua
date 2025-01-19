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
    
    -- spec = {
    --     -- import your plugins
    --     { import = "plugins" },
    -- },
    {
        'rose-pine/neovim',
        as = 'rose-pine',
    },
    {'devsjc/vim-jb'},
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"nvim-lua/plenary.nvim"}, -- don't forget to add this one if you don't have it yet!
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {'mbbill/undotree'},
    {'tpope/vim-fugitive'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        keys = {
            -- 👇 in this section, choose your own keymappings!
            --{
            --    "<leader>-",
            --    mode = { "n", "v" },
            --    "<cmd>Yazi<cr>",
            --    desc = "Open yazi at the current file",
            --},
            --{
            --    -- Open in the current working directory
            --    "<leader>cw",
            --    "<cmd>Yazi cwd<cr>",
            --    desc = "Open the file manager in nvim's working directory" ,
            --},
            --{
            --    -- NOTE: this requires a version of yazi that includes
            --    -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
            --    '<c-up>',
            --    "<cmd>Yazi toggle<cr>",
            --    desc = "Resume the last yazi session",
            --},
        },
        ---@type YaziConfig
        opts = {
            open_for_directories = true,
            keymaps = {
                show_help = '<f1>',
            },
        },
    }
})
