local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

local settings = require("user.lsp.settings")
settings.setup()
require("lspconfig.ui.windows").default_options.border = "single"

lspconfig["sumneko_lua"].setup({
  on_attach = settings.on_attach,
  capabilities = settings.capabilties,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

lspconfig["clangd"].setup({
  on_attach = settings.on_attach,
  capabilities = settings.capabilities,
})

lspconfig["pyright"].setup({
  on_attach = settings.on_attach,
  capabilities = settings.capabilities,
})
