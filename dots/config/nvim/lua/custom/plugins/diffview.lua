return {
  "sindrets/diffview.nvim",
  opts = {
    vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { noremap = true, silent = true, desc = "Diffview Open" }),
    vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewClose<cr>",
      { noremap = true, silent = true, desc = "Diffview Close" }),
    vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory<cr>",
      { noremap = true, silent = true, desc = "Diffview File History" }),
    vim.keymap.set("n", "<leader>gr", "<cmd>DiffviewRefresh<cr>",
      { noremap = true, silent = true, desc = "Diffview Refresh" }),
  }
}
