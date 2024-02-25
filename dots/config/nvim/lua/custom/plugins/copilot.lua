return {
	-- Copilot
	'github/copilot.vim',
	init = function()
		-- Copilot remap to ctrl + enter
		vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
		vim.g.copilot_no_tab_map = true
		vim.g.copilot_filetypes = { markdown = true }
	end,
}
