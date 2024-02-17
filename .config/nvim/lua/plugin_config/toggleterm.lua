require("toggleterm").setup {
  --  open_mapping = [[<C-x>]],
  start_in_insert = true,
  shade_terminals = false,
  highlights = {
    Normal = {
      guibg = "#222224"
    }
  }
}

local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = 'float',
    on_open = function(term)
      vim.keymap.set("t", "<C-x>", [[<Cmd>wincmd k<CR>]], { buffer = term.bufnr })
    end,
    on_close = function(term)
    end

})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true, desc = '[G]it toggle' })

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

vim.cmd('autocmd TermEnter term://*toggleterm#* tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>')
vim.cmd('nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>')
vim.cmd('inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>')

vim.cmd('autocmd TermEnter term://*toggleterm#* tnoremap <silent><c-x> <Cmd>"ToggleTermToggleAll"<CR>')
vim.cmd('nnoremap <silent><c-x> <Cmd>exe "ToggleTermToggleAll"<CR>')
vim.cmd('inoremap <silent><c-x> <Esc><Cmd>exe "ToggleTermToggleAll"<CR>')

