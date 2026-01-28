return {
  'nvim-treesitter/nvim-treesitter',

  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- Skip treesitter setup in headless mode to avoid compilation errors
    if #vim.api.nvim_list_uis() == 0 then
      return
    end

    require("nvim-treesitter").setup({
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "clojure", "ruby", "commonlisp", "dockerfile", "bash", "markdown", "yaml", "json", "html", "javascript", "java" },
      highlight = { enable = true },
      auto_install = true,
      indent = { enable = true },
      autotag = { enable = true },
    })
  end,
}
