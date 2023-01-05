local M = {}

M.kind_icons = {
  Array = " ",
  Boolean = "蘒 ",
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = " ",
  Key = " ",
  Keyword = " ",
  Method = " ",
  Module = " ",
  Namespace = " ",
  Null = "ﳠ ",
  Number = " ",
  Object = " ",
  Operator = " ",
  Package = " ",
  Property = " ",
  Reference = " ",
  Snippet = " ",
  String = " ",
  Struct = " ",
  Text = " ",
  TypeParameter = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

M.diagnostics_icons = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = "",
}

M.diagnostics_signs = {
  { name = "DiagnosticSignError", text = M.diagnostics_icons.Error },
  { name = "DiagnosticSignWarn", text = M.diagnostics_icons.Warn },
  { name = "DiagnosticSignHint", text = M.diagnostics_icons.Hint },
  { name = "DiagnosticSignInfo", text = M.diagnostics_icons.Info },
}

M.setup = function()
  for _, sign in ipairs(M.diagnostics_signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = "", numhl = sign.name })
  end
end

return M
