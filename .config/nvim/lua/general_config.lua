vim.wo.number = true

vim.g.mkdp_echo_preview_url = 1

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.backspace = "2"
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = false
vim.opt.autoread = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- 15 lines padding in buffer top/botton
vim.opt.scrolloff = 15

-- save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Something something??
vim.o.smartindent = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- disable highlighted search (/searchterm)
-- vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- Yank to clipboard (disabled because is slow)
-- vim.api.nvim_set_option("clipboard", "unnamed")

-- sync with system clipboard on focus
vim.api.nvim_create_autocmd({ "FocusGained" }, {
  pattern = { "*" },
  command = [[call setreg("@", getreg("+"))]],
})


-- sync with system clipboard on focus
vim.api.nvim_create_autocmd({ "FocusLost" }, {
  pattern = { "*" },
  command = [[call setreg("+", getreg("@"))]],
})

vim.api.nvim_set_option("clipboard", "")


local telescope = require("telescope")

telescope.setup({
  defaults = { file_ignore_patterns = { "node_modules", ".angular", "dist" } },
  pickers = {
    find_files = {
      hidden = true,
      previewer = false
    },

    oldfiles = {
      cwd_only = true,
      previewer = false
    },

    live_grep = {
      -- https://github.com/nvim-telescope/telescope.nvim/issues/855#issuecomment-1721253959
      additional_args = { "--line-number", "--color=never", "--hidden", "--glob", "!{**/.git/*,**/node_modules/*,**/package-lock.json,**/yarn.lock}" },
      previewer = false
    },

    current_buffer_fuzzy_find = {
      previewer = false
    }
  },

  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "ignore_case",      -- or "ignore_case" or "respect_case"
    }
  }
})

telescope.load_extension("ui-select")

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, "fzf")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
-- vim.api.nvim_create_autocmd("TextYankPost", {
-- 	callback = function()
-- 		vim.highlight.on_yank()
-- 	end,
-- 	group = highlight_group,
-- 	pattern = "*",
-- })

-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		if vim.fn.argv(0) == "" then
-- 			require("telescope.builtin").find_files({
-- 				find_command = { "rg", "--files", "--no-ignore-vcs", "--hidden", "-g", "!.git" },
-- 			})
-- 		end
-- 	end,
-- })
