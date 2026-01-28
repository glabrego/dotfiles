vim.deprecate = function() end

-- lazy.vim plugin manager setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("lazy").setup({
  { import = 'plugins' },
  checker = { enabled = true },

  {'tpope/vim-surround'},
  {'tpope/vim-commentary'},
  {'Raimondi/delimitMate'},
  {'christoomey/vim-tmux-navigator'},
  {'nvim-lualine/lualine.nvim'},
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
  {'tpope/vim-repeat'},
  {'tmhedberg/matchit'},
  {'Olical/conjure'},
  {'williamboman/mason.nvim'},
})

vim.cmd.colorscheme "catppuccin"

require('config.defaults')
require('config.remaps')

-- lualine setup
require('lualine').setup()

-- bufferline setup
require('bufferline').setup()

-- mason setup
require('mason').setup()
