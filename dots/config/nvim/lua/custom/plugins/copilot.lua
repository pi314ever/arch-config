return {
  {
    'zbirenbaum/copilot.lua',
    dependencies = {
      { 'AndreM222/copilot-lualine' },
      { 'ryanoasis/vim-devicons' },
    },
    event = 'InsertEnter',
    opts = {
      suggestion = {
        keymap = {
          accept = '<C-j>',
        },
      },
    },
    keys = {
      {
        '<leader>cp',
        function()
          require('copilot.suggestion').toggle_auto_trigger()
        end,
        desc = '[C]o[P]ilot - Toggle Auto Trigger',
      },
    },
  },
}
