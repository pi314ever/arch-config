return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = function() vim.fn["mkdp#util#install"]() end,
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
		vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>")
		vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreviewStop<cr>")
	end,
	ft = { "markdown" },
}
