return {
  -- Surround text objects (modern Lua rewrite)
  {
    'kylechui/nvim-surround',
    version = "*",
    event = "VeryLazy",
    config = function()
      require('nvim-surround').setup()
    end
  },

  -- Comment toggling (modern Lua alternative)
  {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    config = function()
      require('Comment').setup()
    end
  },

  -- Auto-close brackets/quotes (modern autopairs with cmp integration)
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      require('nvim-autopairs').setup()
    end
  },

  -- Seamless tmux/vim navigation
  'christoomey/vim-tmux-navigator',

  -- Repeat plugin actions with . (still needed for some plugins)
  'tpope/vim-repeat',
}
