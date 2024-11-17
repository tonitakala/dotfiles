function KeyMap(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

-- Toggle nvim-tree on current file
KeyMap("n", "<Space>b", ":Neotree toggle<CR>", { desc = "Toggle FileTree" })

-- Telescope
local builtin = require("telescope.builtin")

-- KeyMap('n', '<c-p>', builtin.find_files)
KeyMap(
  "n",
  "<C-p>",
  "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--no-ignore-vcs', '--hidden', '-g', '!.git' }})<cr>"
)
KeyMap("n", "<Space><Space>", builtin.oldfiles, { desc = "Recent files" })
KeyMap("n", "<Space>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
KeyMap("n", "<Space>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
KeyMap("n", "<Space>fs", builtin.lsp_document_symbols, { desc = "[F]ind document [S]ymbols" })
KeyMap("n", "<Space>fe", builtin.resume, { desc = "[F]ind [E]arlier" })
KeyMap("n", "<C-f>", builtin.current_buffer_fuzzy_find)

KeyMap("n", "<Space>if", ":ConformInfo<CR>", { desc = "[I]nformation about [F]ormatting (:ConformInfo)" })
KeyMap("n", "<Space>il", ":LspInfo<CR>", { desc = "[I]nformation about [L]SP (:LspInfo)" })

-- Toggle between windows (on windows)
if vim.fn.has("win32") == 1 then
  KeyMap("n", "<C-h>", "<C-w>h")
  KeyMap("n", "<C-j>", "<C-w>j")
  KeyMap("n", "<C-k>", "<C-w>k")
  KeyMap("n", "<C-l>", "<C-w>l")
  KeyMap("t", "<C-h>", "<cmd>wincmd h<CR>")
  KeyMap("t", "<C-j>", "<cmd>wincmd j<CR>")
  KeyMap("t", "<C-k>", "<cmd>wincmd k<CR>")
  KeyMap("t", "<C-l>", "<cmd>wincmd l<CR>")
else
  KeyMap("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>")
  KeyMap("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>")
  KeyMap("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>")
  KeyMap("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>")
end

-- Resize windows
KeyMap("n", "<C-Up>", ":resize -2<CR>")
KeyMap("n", "<C-Down>", ":resize +2<CR>")
KeyMap("n", "<C-Left>", ":vertical resize -2<CR>")
KeyMap("n", "<C-Right>", ":vertical resize +2<CR>")
KeyMap("t", "<C-Up>", "<cmd>resize -2<CR>")
KeyMap("t", "<C-Down>", "<cmd>resize +2<CR>")
KeyMap("t", "<C-Left>", "<cmd>vertical resize -2<CR>")
KeyMap("t", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Move blocks of code
KeyMap("v", "J", ":m '>+1<CR>gv=gv")
KeyMap("v", "K", ":m '<-2<CR>gv=gv")

-- Indent blocks of code
KeyMap("v", "<", "<gv")
KeyMap("v", ">", ">gv")

-- Close buffer and retain split
-- vim.keymap.set("n", "<leader>w", "<cmd>bp|bd #<CR>", { desc = "Close Buffer; Retain Split" })

-- Leave insert mode with jj
-- vim.keymap.set("i", "jj", "<Esc>", { desc = "Esc" })

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- Toggle line comment default: gc(c)
-- Toggle block comment default gb(c)

-- Allow pasting without overwriting the default register
vim.keymap.set("v", "p", '"_dP')

-- Make Y behave like C and D
vim.keymap.set("n", "Y", "y$")


-- function WindowsYank()
--   local clip = "/mnt/c/Windows/System32/clip.exe" -- Change this path if needed
--
--   vim.cmd.normal { '"zy', bang = true }
--   -- local selection = vim.fn.getreg("z")
--
--   if vim.fn.executable(clip) then
--     vim.fn.system(clip, vim.fn.getreg("z"))
--   end
-- end
--
-- KeyMap("v", "<Space>y", WindowsYank, { desc = "Windows yank" })
