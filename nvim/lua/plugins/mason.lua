return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        -- Automatically install these LSP servers
        ensure_installed = {
          'lua_ls',
          'clojure_lsp',
        },
        -- Automatically setup LSP servers installed via Mason
        automatic_installation = true,
      })
    end
  }
}
