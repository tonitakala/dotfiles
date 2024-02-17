vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- I = toggle .gitignore
-- H = toggle dotfiles

require("nvim-tree").setup({
  view = {
    width = 40,
    side = 'right'
  },
  filters = {
    git_ignored = false,
    dotfiles = false,
  },
})

