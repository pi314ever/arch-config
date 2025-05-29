return {
  {
    'zbirenbaum/copilot.lua',
    dependencies = {
      { 'AndreM222/copilot-lualine' },
      { 'ryanoasis/vim-devicons' },
    },
    event = 'InsertEnter',
    opts = {
      copilot_model = 'claude-3.7-sonnet',
      suggestion = {
        keymap = {
          accept = '<C-j>',
        },
      },
    },
    keys = {
      {
        '<leader>CP',
        function()
          require('copilot.suggestion').toggle_auto_trigger()
        end,
        desc = '[C]o[P]ilot - Toggle Auto Trigger',
      },
    },
  },
  {
    -- Copilot Chat
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      debug = true,
    },
    keys = {
      {
        '<leader>Cc',
        function()
          require('CopilotChat').toggle()
        end,
        desc = '[Co]pilot[C]hat - Toggle',
      },
      {
        '<leader>Cq',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end
        end,
        desc = '[C]opilotChat - [Q]uick chat',
      },
      {
        '<leader>Cp',
        function()
          local actions = require 'CopilotChat.actions'
					require('CopilotChat').select_prompt()
          require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
        end,
        desc = '[C]opilotChat - [p]rompt actions',
        mode = { 'n', 'v' },
      },
    },
  },
}
