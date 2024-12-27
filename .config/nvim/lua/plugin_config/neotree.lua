require("neo-tree").setup({
  close_if_last_window = true,
  toggle = true,
  buffers = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false
    }
  },
  filesystem = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false
    }
  },
  window = {
    position = "right",
    width = 40
  }
})
