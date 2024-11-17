local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

local plugins = {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },
  { "nvim-tree/nvim-web-devicons",              lazy = true },
  -- { "nvim-tree/nvim-tree.lua" },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  {
    "kkoomen/vim-doge",
    config = function()
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "BufWinEnter",
    config = function()
      require("lualine").setup({
        options = {
          theme = "vscode",
          icons_enabled = true,
        },
        sections = {
          lualine_a = {
            {
              "filename",
              path = 1,
            },
          },
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "lua", "javascript", "html", "css", "json", "typescript", "bicep" },

        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
        }
      })
    end,
  },

  {
    "github/copilot.vim",
    event = "BufWinEnter",
  },

  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
      vim.g.startuptime_tries = 5
    end,
  },

  { -- Install ripgrep to optimize telescope: https://github.com/BurntSushi/ripgrep
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
  },

  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },


  {
    "lewis6991/gitsigns.nvim",
    event = "BufWinEnter",
    config = function()
      require("gitsigns").setup({
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },

      })
    end,
  },

  {
    "stevearc/conform.nvim",
  },

  {
    "williamboman/mason.nvim",
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
  },

  {
    "hrsh7th/cmp-nvim-lsp",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-nvim-lsp-signature-help"
    },
  },

  {
    "numToStr/Comment.nvim",
    opts = {

    },
    lazy = false
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup()
    end,
  },

  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500

      local wk = require("which-key")
      wk.setup();
    end,
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      -- { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      -- { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      -- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    'echasnovski/mini.surround',
    version = false,
    opts = {

      mappings = {
        add = 'ma',          -- Add surrounding in Normal and Visual modes
        delete = 'md',       -- Delete surrounding
        find = '',           -- Find surrounding (to the right)
        find_left = '',      -- Find surrounding (to the left)
        highlight = 'mh',    -- Highlight surrounding
        replace = 'mr',      -- Replace surrounding
        update_n_lines = '', -- Update `n_lines`

        suffix_last = '',    -- Suffix to search with "prev" method
        suffix_next = '',    -- Suffix to search with "next" method
      },

    }
  },

  -- {
  --   'norcalli/nvim-colorizer.lua',
  --   config = function()
  --     require('colorizer').setup({
  --       '*', -- Highlight all files, but customize some others.
  --       css = { rgb_fn = true }
  --     })
  --   end
  -- }

}

require("lazy").setup(plugins)
