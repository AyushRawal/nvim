local ap_ok, autopairs = pcall(require, "nvim-autopairs")

if ap_ok then
  autopairs.setup({
    disable_in_visualblock = true,
    -- disable_in_macro = true,
    fast_wrap = {},
  })
end

local col_ok, colorizer = pcall(require, "colorizer")

if col_ok then
  colorizer.setup({
    "*",
    css = { css = true },
  }, { names = false })
end
