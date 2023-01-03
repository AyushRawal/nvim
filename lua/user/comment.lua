local ok, comment = pcall(require, "Comment")

if not ok then
	return
end

local ok2, ts_context_commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
local pre_hook = nil
if ok2 then
	pre_hook = ts_context_commentstring.create_pre_hook()
end

local keymaps = require("user.keymaps")
comment.setup({
	---Add a space b/w comment and the line
	padding = true,
	---Whether the cursor should stay at its position
	sticky = true,
	---Lines to be ignored while (un)comment
	ignore = nil,

	-- keybindings
	toggler = keymaps.comment.toggler,
	opleader = keymaps.comment.opleader,
	extra = keymaps.comment.extra,

	---Enable keybindings
	---NOTE: If given `false` then the plugin won't create any mappings
	mappings = {
		---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
		basic = true,
		---Extra mapping; `gco`, `gcO`, `gcA`
		extra = true,
	},
	---Function to call before (un)comment
	pre_hook = pre_hook,
	---Function to call after (un)comment
	post_hook = nil,
})
