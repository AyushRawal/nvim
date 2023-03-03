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

local null_ok, null_ls = pcall(require, "null-ls")

if null_ok then
  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.diagnostics.shellcheck,
    },
    border = "single",
    on_attach = require("user.lsp.settings").on_attach,
  })
end

local gs_ok, gs = pcall(require, "gitsigns")

if gs_ok then
  gs.setup({
    current_line_blame_opts = {
      virt_text_opts = "right_align",
    },
    on_attach = require("user.keymaps").gitsigns,
  })
end
