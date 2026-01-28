vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.keymap.set('n', '<leader>c', ':edit $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>cs', ':source $MYVIMRC<CR>')

vim.keymap.set('n', '<leader>w', ':w!<CR>', { desc = 'Double ESC to save :)', silent = true })

vim.keymap.set('n', '<C-H>', ':<C-U>TmuxNavigateLeft<cr>')
vim.keymap.set('n', '<C-J>', ':<C-U>TmuxNavigateDown<cr>')
vim.keymap.set('n', '<C-K>', ':<C-U>TmuxNavigateUp<cr>')
vim.keymap.set('n', '<C-L>', ':<C-U>TmuxNavigateRight<cr>')
vim.keymap.set('n', '<leader>=', '<C-W><C-=>')
vim.keymap.set('n', '<leader>o', '<C-W><C-o>')
vim.keymap.set('n', '<leader><tab>', ':b#<cr>')
vim.keymap.set('n', '<leader>l', ':bnext<cr>')
vim.keymap.set('n', '<leader>h', ':bprevious<cr>')
vim.keymap.set('n', '<leader>bq', ':bp <BAR> bd #<CR>')
vim.keymap.set('n', '<leader>\\', ':vs <CR>')
vim.keymap.set('n', '<leader>-', ':sp <CR>')

vim.keymap.set('i', '<C-H>', '<Left>')
vim.keymap.set('i', '<C-J>', '<Down>')
vim.keymap.set('i', '<C-K>', '<Up>')
vim.keymap.set('i', '<C-L>', '<Right>')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'j', 'gj')

vim.keymap.set('n', '<leader>q', ':nohlsearch<CR>')
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

vim.keymap.set('n', '<leader>F', ':%! jq . <CR>')
