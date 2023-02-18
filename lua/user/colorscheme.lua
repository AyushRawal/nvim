vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
vim.g.gruvbox_material_sign_column_background = "grey"
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_background = "hard"

local hl = vim.api.nvim_set_hl

local gruvbox_custom = function()
  -- lsp and floats
  hl(0, "NormalFloat", { link = "Normal" })
  hl(0, "FloatBorder", { link = "Normal" })
  hl(0, "ErrorFloat", { link = "DiagnosticSignError" })
  hl(0, "WarningFloat", { link = "DiagnosticSignWarn" })
  hl(0, "HintFloat", { link = "DiagnosticSignHint" })
  hl(0, "InfoFloat", { link = "DiagnosticSignFloat" })
  -- telescope
  local TelescopePrompt = {
    TelescopePromptNormal = {
      bg = "#a89984",
      fg = "#282828",
      bold = true,
    },
    TelescopePromptBorder = {
      bg = "#a89984",
      fg = "#a89984",
    },
    TelescopePromptTitle = {
      bg = "#a89984",
      fg = "#a89984",
    },
    TelescopePromptPrefix = {
      fg = "#563244",
    },
    TelescopeNormal = {
      bg = "#141617",
    },
    TelescopeBorder = {
      fg = "#141617",
      bg = "#141617",
    },
  }
  for hi, col in pairs(TelescopePrompt) do
    vim.api.nvim_set_hl(0, hi, col)
  end
end

local group = vim.api.nvim_create_augroup("GruvboxCustom", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "gruvbox-material", callback = gruvbox_custom, group = group })

vim.cmd.colorscheme("gruvbox-material")

local highlights = {
  NavicIconsFile = "CmpItemKindFile",
  NavicIconsModule = "CmpItemKindModule",
  NavicIconsNamespace = "CmpItemKindModule",
  NavicIconsPackage = "CmpItemKindFolder",
  NavicIconsClass = "CmpItemKindClass",
  NavicIconsMethod = "CmpItemKindMethod",
  NavicIconsProperty = "CmpItemKindProperty",
  NavicIconsField = "CmpItemKindField",
  NavicIconsConstructor = "CmpItemKindConstructor",
  NavicIconsEnum = "CmpItemKindEnum",
  NavicIconsInterface = "CmpItemKindInterface",
  NavicIconsFunction = "CmpItemKindFunction",
  NavicIconsVariable = "CmpItemKindVariable",
  NavicIconsConstant = "CmpItemKindConstant",
  NavicIconsString = "CmpItemKindValue",
  NavicIconsNumber = "CmpItemKindValue",
  NavicIconsBoolean = "CmpItemKindValue",
  NavicIconsArray = "CmpItemKindValue",
  NavicIconsObject = "CmpItemKindValue",
  NavicIconsKey = "CmpItemKindValue",
  NavicIconsNull = "CmpItemKindValue",
  NavicIconsEnumMember = "CmpItemKindEnumMember",
  NavicIconsStruct = "CmpItemKindStruct",
  NavicIconsEvent = "CmpItemKindEvent",
  NavicIconsOperator = "CmpItemKindOperator",
  NavicIconsTypeParameter = "CmpItemKindTypeParameter",
  NavicText = "WinBar",
  NavicSeparator = "Conceal",
}
for from, to in pairs(highlights) do
  vim.api.nvim_set_hl(0, from, { link = to, default = true })
end
