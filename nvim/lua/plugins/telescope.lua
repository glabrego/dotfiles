return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = { 'node_modules', '.git/' },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        }
      },
      pickers = {
        find_files = {
          hidden = true,
          theme = 'ivy'
        },
        live_grep = {
          theme = 'ivy'
        },
        buffers = {
          theme = 'ivy'
        },
        builtin = {
          theme = 'ivy'
        }
      }
    }

    -- Avoid startup errors if native extension is not built yet.
    pcall(require('telescope').load_extension, 'fzf')

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>f', builtin.find_files)
    vim.keymap.set('n', '<leader>p', builtin.live_grep)
    vim.keymap.set('n', '<leader>b', builtin.builtin)
    vim.keymap.set('n', '<space><space>', builtin.buffers)
    vim.keymap.set('n', '<leader>en', function()
      builtin.find_files({ cwd = vim.fn.stdpath('config') })
    end)
  end
}
