return {
  "nvimtools/none-ls.nvim",
  requires = { "nvim-lua/plenary.nvim" },

  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- null_ls.builtins.formatting.black,
        -- null_ls.builtins.formatting.isort,
        -- null_ls.builtins.formatting.clang_format,
        -- null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.latexindent,
      },
    })
    vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "[F]or[m]at document" })
  end,

}
