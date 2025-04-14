vim.g.rustaceanvim = {
  -- LSP configuration
  server = {
    on_attach = require('helpers.lsp').on_attach,
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
        cargo = {
          features = 'all',
          buildScripts = {
            enable = true,
          },
        },
        checkOnSave = {
          command = 'clippy',
          extraArgs = { '--', '-W', 'clippy::pedantic' },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  },
}
return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false, -- This plugin is already lazy
}
