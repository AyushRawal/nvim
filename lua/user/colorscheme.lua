-- require("catppuccin").setup({
--   flavour = "mocha", -- latte, frappe, macchiato, mocha
--   background = { -- :h background
--     light = "latte",
--     dark = "mocha",
--   },
--   transparent_background = false,
--   term_colors = false,
--   dim_inactive = {
--     enabled = false,
--     shade = "dark",
--     percentage = 0.15,
--   },
--   no_italic = false, -- Force no italic
--   no_bold = false, -- Force no bold
--   styles = {
--     comments = { "italic" },
--     conditionals = { "italic" },
--     loops = {},
--     functions = {},
--     keywords = {},
--     strings = {},
--     variables = {},
--     numbers = {},
--     booleans = {},
--     properties = {},
--     types = {},
--     operators = {},
--   },
--   color_overrides = {},
--   custom_highlights = {},
--   integrations = {
--     cmp = true,
--     gitsigns = true,
--     neotree = true,
--     telescope = true,
--     notify = false,
--     mini = false,
--     -- treesitter = true,
--     navic = {
--       enabled = true,
--       custom_bg = "NONE",
--     },
--     native_lsp = {
--       enabled = true
--     },
--     -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
--   },
-- })
-- local highlights = {
--   NeoTreeDirectoryIcon = "NvimTreeFolderIcon",
--   -- NeoTreeDirectoryName = "NvimTreeFolderName",
--   -- NeoTreeSymbolicLinkTarget = "NvimTreeSymlink",
--   NeoTreeRootName = "NvimTreeRootFolder",
--   -- NeoTreeFileNameOpened = "NvimTreeOpenedFile"
--   NeoTreeGitDeleted = "NvimTreeGitDeleted",
--   NeoTreeGitIgnored = "NvimTreeGitIgnored",
--   NeoTreeGitAdded = "NvimTreeGitNew",
--   NeoTreeGitRenamed = "NvimTreeGitRenamed",
--   NeoTreeGitStaged = "NvimTreeGitStaged",
--   NeoTreeGitModified = "NvimTreeGitDirty",
--   NeoTreeNormal = "NvimTreeNormal",
--   NeoTreeNormalNC = "NvimTreeNormalNC",
--   NeoTreeSignColumn = "NvimTreeSignColumn",
--   NeoTreeVertSplit = "NvimTreeVertSplit",
--   NeoTreeWinSeparator = "NvimTreeWinSeparator",
--   NeoTreeIndentMarker = "NvimTreeIndentMarker",
--   NeoTreeEndOfBuffer = "NvimTreeEndOfBuffer",
-- }
-- for from, to in pairs(highlights) do
--   vim.api.nvim_set_hl(0, from, { link = to, default = true, })
-- end

-- require("mellifluous").setup()

-- setup must be called before loading
-- vim.cmd.colorscheme "rose-pine"
-- vim.cmd.colorscheme "mellifluous"

vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
vim.g.gruvbox_material_sign_column_background = "grey"
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_enable_bold = 1

local hl = vim.api.nvim_set_hl

local gruvbox_custom = function()
  -- lsp and floats
  hl(0, "NormalFloat", { link = "Normal" })
  hl(0, "FloatBorder", { link = "Normal" })
  hl(0, "ErrorFloat", { link = "DiagnosticSignError" })
  hl(0, "WarningFloat", { link = "DiagnosticSignWarning" })
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
