return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { silent = true })
    vim.keymap.set('n', '<leader>t', ':NvimTreeFindFile<CR>', { silent = true })

    require("nvim-tree").setup {}
  end,
}
