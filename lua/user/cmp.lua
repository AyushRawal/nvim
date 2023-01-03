local ok, cmp = pcall(require, "cmp")
local ok2, luasnip = pcall(require, "luasnip")

if not ok or not ok2 then
	print("cmp not loaded")
	return
end

local kind_icons = require("user.settings").kind_icons

-- load snippets
require("luasnip.loaders.from_vscode").lazy_load()
local keymaps = require("user.keymaps")
keymaps.luasnip(luasnip)

-- local has_words_before = function()
--   unpack = unpack or table.unpack
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered({ border = "single" }),
		documentation = cmp.config.window.bordered({ border = "single" }),
	},
	mapping = cmp.mapping.preset.insert(keymaps.cmp(cmp)),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
	formatting = {
		format = function(_, vim_item)
			vim_item.kind = string.format("   %s%s", kind_icons[vim_item.kind], vim_item.kind)
			-- vim_item.menu = ({
			--   buffer = "[Buffer]",
			--   nvim_lsp = "[LSP]",
			--   luasnip = "[LuaSnip]",
			-- })[entry.source.name]
			return vim_item
		end,
	},
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
	formatting = {
		format = function(_, vim_item)
			vim_item.kind = ""
			vim_item.menu = ""
			return vim_item
		end,
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
	formatting = {
		format = function(_, vim_item)
			vim_item.kind = ""
			vim_item.menu = ""
			return vim_item
		end,
	},
})
