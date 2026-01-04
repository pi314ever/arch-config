return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      provider = {
        enabled = 'snacks',
        snacks = {
          win = {
            enter = true, -- Focus opencode terminal when opened.
          },
        },
      },
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    -- Recommended/example keymaps.
    vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'Ask opencode' })
    vim.keymap.set({ 'n', 'x' }, '<leader>ox', function()
      require('opencode').select()
    end, { desc = 'Execute opencode action…' })
    vim.keymap.set({ 'n' }, '<leader>ot', function()
      require('opencode').toggle()
    end, { desc = 'Toggle opencode terminal' })

    vim.keymap.set({ 'n', 't' }, '<M-C-o>', function()
      require('opencode').toggle()
    end, { desc = 'Toggle opencode terminal' })

    vim.keymap.set({ 'n', 'x' }, 'go', function()
      if vim.fn.mode() == 'n' then
        return require('opencode').operator '@this ' .. '_'
      else
        return require('opencode').operator '@this '
      end
    end, { expr = true, desc = 'Add range to opencode' })
  end,
}
