local ok, telescope = pcall(require, "telescope")

if not ok then
  return
end

telescope.setup({
  defaults = {
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.60,
        results_width = 0.40,
      },
      vertical = {
        mirror = false,
      },
      width = 0.80,
      height = 0.80,
      preview_cutoff = 120,
    },
    prompt_prefix = "   ",
    selection_caret = " ",
    multi_icon = "+ ",
    -- results_title = false,
    -- border = false,
    -- borderchars = {
    --   { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    --   prompt = { "─", "│", "─", "│", '┌', '┐', "┤", "├" },
    --   results = { " ", "│", "─", "│", "│", "│", "┘", "└" },
    --   preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    -- },
    -- borderchars = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
  },
})

telescope.load_extension("fzf")

local keymaps = require("user.keymaps")
keymaps.telescope(require("telescope.builtin"))
