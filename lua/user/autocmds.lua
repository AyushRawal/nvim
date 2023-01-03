local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local myGroup = augroup("myGroup", { clear = true })

-- turn off relative numbers in insert mode
autocmd("InsertEnter", {
	callback = function()
		vim.opt.relativenumber = false
	end,
	group = myGroup,
})
autocmd("InsertLeave", {
	callback = function()
		if vim.opt.number._value == true then
			vim.opt.relativenumber = true
		end
	end,
	group = myGroup,
})

-- add formatoptiona
autocmd("BufWinEnter", {
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
	group = myGroup,
})

-- highlight text on yank
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 400,
		})
	end,
	group = myGroup,
})

-- clear highlights
vim.on_key(function(char)
	if vim.fn.mode() == "n" then
		vim.opt.hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
	end
end, vim.api.nvim_create_namespace("auto_hlsearch"))

-- remove trailing whitespaces before writing
autocmd("BufWritePre", {
	pattern = "*",
	command = [[%s/\s\+$//e]],
	group = myGroup,
})

-- show cursor line only in active window
vim.api.nvim_create_autocmd("WinEnter", {
	callback = function()
		local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
		if ok and cl then
			vim.wo.cursorline = true
			vim.api.nvim_win_del_var(0, "auto-cursorline")
		end
	end,
	group = myGroup,
})
vim.api.nvim_create_autocmd("WinLeave", {
	callback = function()
		local cl = vim.wo.cursorline
		if cl then
			vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
			vim.wo.cursorline = false
		end
	end,
	group = myGroup,
})
