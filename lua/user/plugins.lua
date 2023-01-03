local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")
		-- My plugins here
		-- colorscheme
		use("sainnhe/gruvbox-material")
		use("ellisonleao/gruvbox.nvim")
		use("luisiacc/gruvbox-baby")
		use({ "catppuccin/nvim", as = "catppuccin" })
		use({ "rose-pine/neovim", as = "rose-pine" })
		use("lourenci/github-colors")
		use("projekt0n/github-nvim-theme")
		use({ "ramojus/mellifluous.nvim", requires = { "rktjmp/lush.nvim" } })
		use("Yazeed1s/minimal.nvim")
		use({ "bluz71/vim-moonfly-colors", branch = "cterm-compat" })

		-- treesitter
		use("nvim-treesitter/nvim-treesitter")
    use('nvim-treesitter/nvim-treesitter-textobjects')

		-- Comments
		use("numToStr/Comment.nvim")
		use("JoosepAlviste/nvim-ts-context-commentstring")

		-- pairs and tags
		use("windwp/nvim-autopairs")
		use("tpope/vim-surround")

		-- icons
		use("kyazdani42/nvim-web-devicons")

    -- indentlines
    use("lukas-reineke/indent-blankline.nvim")

		-- git
		use("lewis6991/gitsigns.nvim")

		use("nvim-lua/plenary.nvim")
		use("MunifTanjim/nui.nvim")

		-- lsp
		use("williamboman/mason.nvim")
		use("neovim/nvim-lspconfig")

		use({ "nvim-neo-tree/neo-tree.nvim", branch = "v2.x" })

    -- telescope
    use({ 'nvim-telescope/telescope.nvim', tag = '0.1.0' })
    use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

		-- autocomplete
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-cmdline")
		use("hrsh7th/nvim-cmp")

		-- snipptets
		use("L3MON4D3/LuaSnip")
		use("saadparwaiz1/cmp_luasnip")
		use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

		-- code context
		use("SmiteshP/nvim-navic")

		-- tabline
		use({ "akinsho/bufferline.nvim", tag = "v3.*" })

		-- statusline
		use("nvim-lualine/lualine.nvim")

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
