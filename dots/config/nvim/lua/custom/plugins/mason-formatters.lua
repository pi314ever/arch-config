return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim", },
	config = function()
		require("mason").setup()
		require("mason-null-ls").setup({
			ensure_installed = {
				"ruff",
				"prettier",
				"clang-format",
				"marksman",
				"latexindent",
				"shfmt",
			},
			automatic_installation=true,
			handlers={},
		})
		require("null-ls").setup()
	end,
}
