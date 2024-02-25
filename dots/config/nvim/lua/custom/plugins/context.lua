return {
	"nvim-treesitter/nvim-treesitter-context",
	opts = function()
		require('treesitter-context').setup({
			max_lines = 10,
			multiline_threshold = 10, 
		})
	end
}
