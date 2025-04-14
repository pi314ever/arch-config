return {
  'sindrets/diffview.nvim',
  opts = {
    vim.keymap.set('n', '<leader>gdo', '<cmd>DiffviewOpen<cr>', { noremap = true, silent = true, desc = 'Diffview Open' }),
    vim.keymap.set('n', '<leader>gdc', '<cmd>DiffviewClose<cr>', { noremap = true, silent = true, desc = 'Diffview Close' }),
    vim.keymap.set('n', '<leader>gdh', '<cmd>DiffviewFileHistory<cr>', { noremap = true, silent = true, desc = 'Diffview File History' }),
    vim.keymap.set('n', '<leader>gdr', '<cmd>DiffviewRefresh<cr>', { noremap = true, silent = true, desc = 'Diffview Refresh' }),
  },
}
