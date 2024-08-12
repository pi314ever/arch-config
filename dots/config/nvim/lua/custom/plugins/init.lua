-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- Custom tabstop and shiftwidth
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false

vim.filetype.add { filename = { ['.envrc'] = 'sh' } }
return {
	-- Custom keybinds
	vim.keymap.set('n', ',', '<cmd>noh<CR>'),

	vim.api.nvim_create_autocmd('FileType', {
		pattern = 'python',
		callback = function()
			vim.opt.tabstop = 4
			vim.opt.shiftwidth = 4
			vim.opt.expandtab = true
		end,
	}),
}
