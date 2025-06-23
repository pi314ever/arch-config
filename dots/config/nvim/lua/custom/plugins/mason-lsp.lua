-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = {
  basedpyright = {
    basedpyright = {
      analysis = {
        useLibraryCodeForTypes = true,
        typeCheckingMode = 'basic',
        autoSearchPath = true,
        inlayHints = true,
      },
      reportPrivateUsage = false,
      useLibraryCodeForTypes = true,
    },
  },
  bashls = {},
  marksman = {},
  texlab = {},
  dockerls = {},
  clangd = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      diagnostics = { disable = { 'missing-fields' } },
    },
  },
  ruff = {},
}

vim.lsp.config('*', {
  capabilities = capabilities,
  on_attach = require('helpers.lsp').on_attach,
})
vim.lsp.inlay_hint.enable(true)

return {
  'mason-org/mason-lspconfig.nvim',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'neovim/nvim-lspconfig',
    { 'j-hui/fidget.nvim', opts = {} },
  },
  opts = function(_, opts)
    opts.ensure_installed = vim.tbl_keys(servers)
    for server, config in pairs(servers) do
      vim.lsp.config(server, {
        settings = config,
        filetypes = (config or {}).filetypes,
      })
      vim.lsp.enable(server)
    end
  end,
}
