return {
  'nvim-treesitter/nvim-treesitter',

  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "clojure", "ruby", "commonlisp", "dockerfile", "bash", "markdown", "yaml", "json", "html", "javascript", "java" },
      highlight = { enable = true, },
      auto_install = true,
      indent = { enable = true },
    })
  end,
}
