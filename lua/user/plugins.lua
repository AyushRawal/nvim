local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- colorscheme
  "sainnhe/gruvbox-material",

  -- which key
  "folke/which-key.nvim",

  -- treesitter
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-textobjects",

  -- Comments
  "numToStr/Comment.nvim",
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- pairs and tags
  "windwp/nvim-autopairs",
  "tpope/vim-surround",

  -- icons
  "kyazdani42/nvim-web-devicons",

  -- indentlines
  "lukas-reineke/indent-blankline.nvim",

  -- git
  "lewis6991/gitsigns.nvim",

  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",

  -- lsp
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",

  "jose-elias-alvarez/null-ls.nvim",

  { "nvim-neo-tree/neo-tree.nvim", branch = "v2.x" },

  -- telescope
  { "nvim-telescope/telescope.nvim", version = "0.1.0" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- autocomplete
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",

  -- snipptets
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- code context
  "SmiteshP/nvim-navic",

  -- tabline
  { "akinsho/bufferline.nvim", version = "v3.*" },

  -- statusline
  "nvim-lualine/lualine.nvim",

  "norcalli/nvim-colorizer.lua",
}, {
  ui = {
    border = "single",
  },
})
