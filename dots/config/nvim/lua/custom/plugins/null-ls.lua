return {
  'nvimtools/none-ls.nvim',
  requires = { 'nvim-lua/plenary.nvim' },

  config = function()
    vim.keymap.set('n', '<leader>fm', vim.lsp.buf.format, { desc = '[F]or[m]at document' })
  end,
}
