local M = {}
local settings = require("user.settings")
local ok, navic = pcall(require, "nvim-navic")

if ok then
  navic.setup({
    icons = require("user.settings").kind_icons,
    highlight = true,
    separator = " > ",
    depth_limit = 0,
    depth_limit_indicator = "..",
    safe_output = true,
  })
end

M.setup = function()
  local config = {
    virtual_text = {
      active = true,
      format = function(diagnostic)
        local icon
        if diagnostic.severity == vim.diagnostic.severity.ERROR then
          icon = settings.diagnostics_icons.Error
        elseif diagnostic.severity == vim.diagnostic.severity.WARN then
          icon = settings.diagnostics_icons.Warn
        elseif diagnostic.severity == vim.diagnostic.severity.HINT then
          icon = settings.diagnostics_icons.Hint
        elseif diagnostic.severity == vim.diagnostic.severity.INFO then
          icon = settings.diagnostics_icons.Info
        end
        return string.format("%s %s", icon, diagnostic.message)
      end,
      prefix = "",
    },
    -- signs = false,
    signs = {
      active = true,
      values = settings.diagnostics_signs,
    },
    -- update_in_insert = false,
    underline = false,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "single",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", { callback = vim.lsp.buf.document_highlight, group = group, buffer = 0 })
    vim.api.nvim_create_autocmd("CursorMoved", { callback = vim.lsp.buf.clear_references, group = group, buffer = 0 })
  end
end

M.on_attach = function(client, bufnr)
  --  if client.name == "tsserver" then
  --    client.resolved_capabilities.document_formatting = false
  --  end
  -- lsp_keymaps(bufnr)
  if client.server_capabilities.documentSymbolProvider and ok then
    navic.attach(client, bufnr)
  end
  require("user.keymaps").lsp(bufnr)
  lsp_highlight_document(client)
end

local ok2, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if ok2 then
  M.capabilities = cmp_nvim_lsp.default_capabilities()
end

return M
