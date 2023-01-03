local ok, lualine = pcall(require, "lualine")

if not ok then
	return
end

local ok2, navic = pcall(require, "nvim-navic")
local diff_source = function()
	local gs = vim.b.gitsigns_status_dict
	if gs then
		return {
			added = gs.added,
			modified = gs.changed,
			removed = gs.removed,
		}
	end
end

local diagnostics_icons = require("user.settings").diagnostics_icons

lualine.setup({
	options = {
		icons_enabled = true,
		-- theme = 'catppuccin',
		theme = "gruvbox-material",
		-- component_separators = { left = '', right = '' },
		-- section_separators = { left = '', right = '' },
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = { "neo-tree", "packer", "qf", "help" },
		},
		ignore_focus = { "neo-tree" },
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{
				"filetype",
				icon_only = true,
				padding = { left = 1, right = 0 },
			},
			{
				"filename",
				path = 1,
			},
		},
		lualine_c = {
			{
				"b:gitsigns_head",
				icon = "",
			},
			{
				"diff",
				source = diff_source,
			},
		},
		lualine_x = {
			{
				function()
					local clients = vim.lsp.get_active_clients({ bufnr = 0 })
					if next(clients) == nil then
						return ""
					end
					local s = "  LSP ~ "
					for _, client in ipairs(clients) do
						s = s .. client.name .. " "
					end
					return s
				end,
			},
		},
		lualine_y = {
			{
				function()
					local type = "Tab: "
					if vim.api.nvim_buf_get_option(0, "expandtab") then
						type = "Spaces: "
					end
					return type .. vim.api.nvim_buf_get_option(0, "shiftwidth")
				end,
				separator = "|",
			},
		},
		lualine_z = {
			"location",
			{
				"progress",
				fmt = function()
					return "%P/%L"
				end,
				color = {},
				padding = { left = 0, right = 1 },
			},
		},
	},
	inactive_sections = {},
	tabline = {},
	winbar = {
		-- lualine_b = { 'fileformat' },
		lualine_c = {
			{
				function()
					return ""
				end,
				color = function()
					local colors = {
						green = vim.g.terminal_color_2,
						red = vim.g.terminal_color_1,
					}
					local buf = vim.api.nvim_get_current_buf()
					local ts = vim.treesitter.highlighter.active[buf]
					return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
				end,
				separator = "│",
			},
			{
				-- navic.get_location,
				-- cond = navic.is_available
				function()
					if ok2 then
						return navic.is_available() and navic.get_location() or " "
					end
				end,
				-- separator = { "" }
			},
		},
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = {
					error = diagnostics_icons.Error .. " ",
					warn = diagnostics_icons.Warn .. " ",
					info = diagnostics_icons.Info .. " ",
					hint = diagnostics_icons.Hint .. " ",
				},
			},
		},
	},
	inactive_winbar = {
		lualine_a = {
			{
				"filename",
				path = 1,
			},
		},
		lualine_b = { "diff" },
		lualine_x = { "filetype" },
		lualine_y = { "location" },
		lualine_z = { "progress" },
	},
	extensions = { "quickfix" },
})
