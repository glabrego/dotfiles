return {
  'neovim/nvim-lspconfig', event = {'BufReadPre', 'BufNewFile'},
  config = function()
    -- Temporarily suppress lspconfig deprecation warnings
    -- The plugin will update to new vim.lsp.config API in v3.0.0
    local deprecate = vim.deprecate
    vim.deprecate = function() end

    local lspconfig = require('lspconfig')
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    vim.diagnostic.config({ jump = { float = true }})

    local on_attach = function(_, bufnr)
      opts.buffer = bufnr

      -- set keybinds
      opts.desc = "Show LSP references"
      keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()
    -- Set default position encoding for Neovim 0.11 compatibility
    capabilities.offsetEncoding = { 'utf-16', 'utf-8' }
    capabilities.general = capabilities.general or {}
    capabilities.general.positionEncodings = { 'utf-16', 'utf-8' }

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {severity_sort = true, update_in_insert = true, underline = true, virtual_text = false}),
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single"}),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})
    }
    -- Clojure LSP setup
    lspconfig.clojure_lsp.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      handlers = handlers,
    })

    -- Lua LSP setup
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    -- Restore original deprecate function
    vim.deprecate = deprecate
  end
}
