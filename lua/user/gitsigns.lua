local ok, gs = pcall(require, "gitsigns")

if not ok then
	return
end

gs.setup({
	current_line_blame_opts = {
		virt_text_opts = "right_align",
	},
	on_attach = require("user.keymaps").gitsigns,
})
