require("mason").setup()
require("mason-lspconfig").setup({})

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require("lspconfig")["tsserver"].setup({
  capabilities = capabilities,
})

require("lspconfig")["lua_ls"].setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      }
    }
  }
})

require("lspconfig")["bicep"].setup({
  capabilities = capabilities,
  filetypes = { "bicep", "bicepparam" },
})

require("lspconfig")["marksman"].setup({
  capabilities = capabilities,
})

require("lspconfig")["yamlls"].setup({
  capabilities = capabilities,
})

require("lspconfig")["jsonls"].setup({
  capabilities = capabilities,
})

require("lspconfig")["html"].setup({
  capabilities = capabilities,
})

require("lspconfig")["cssls"].setup({
  capabilities = capabilities,
})

require("lspconfig")["angularls"].setup({
  capabilities = capabilities,
})

local pse_bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services"
local pse_command_fmt =
[[& '%s/PowerShellEditorServices/Start-EditorServices.ps1' -BundledModulesPath '%s' -LogPath '%s/powershell_es.log' -SessionDetailsPath '%s/powershell_es.session.json' -FeatureFlags @() -AdditionalModules @() -HostName nvim -HostProfileId 0 -HostVersion 1.0.0 -Stdio -LogLevel Normal]]
local pse_temp_path = vim.fn.stdpath("cache")
local pse_command = pse_command_fmt:format(pse_bundle_path, pse_bundle_path, pse_temp_path, pse_temp_path)

require("lspconfig")["powershell_es"].setup({
  filetypes = { "ps1" },
  bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
  settings = { powershell = { codeFormatting = { Preset = 'OTBS' } } },
  cmd = { "pwsh", "-NoLogo", "-Command", pse_command },
  -- capabilities = capabilities,
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
-- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    -- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
    --  you are using nvim-cmp do not use neovim's built-in omnifunc as it cannot support the additional completion items returned from servers due to the capabilities enabled by nvim-cmp
    -- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>lr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "[LSP] Rename" }))
    vim.keymap.set({ "n", "v" }, "<space>lc", vim.lsp.buf.code_action,
      vim.tbl_extend("force", opts, { desc = "[LSP] Code Action" }))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    -- vim.keymap.set('n', '<space>f', function()
    --  vim.lsp.buf.format { async = true }
    -- end, opts)
  end,
})

vim.diagnostic.config({
  signs = true,
  underline = true,
  severity_sort = true,
  virtual_text = {
    prefix = "",
    spacing = 4,
  },
  update_in_insert = false,
  severity = {
    error = "",
    warning = "",
    information = "",
    hint = "",
  }
})
