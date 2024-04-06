local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED
--
vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = "[A]dd to harpoon" })
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "[H]arpoon list" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<M-p>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<M-n>", function() harpoon:list():next() end)
