local prettierConfigDirectory

if vim.fn.has("win32") == 1 then
  prettierConfigDirectory = "C:/Users/toni.takala/AppData/Local/nvim/.prettierrc.json"
else
  prettierConfigDirectory = "$HOME/.prettierrc"
end

require("conform").setup({
  formatters_by_ft = {
    lua = { "lua_ls" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    markdown = { "prettierd" },
    yaml = { "prettierd" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1500,
    lsp_fallback = true,
  },

  formatters = {
    prettierd = {
      env = {
        PRETTIERD_DEFAULT_CONFIG = prettierConfigDirectory
      },
    },
  },
})
