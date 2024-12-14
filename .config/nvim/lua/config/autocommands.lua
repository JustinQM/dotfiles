--enable highlighting for ssa files (qbe IL)
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
	pattern = {"*.ssa"},
	callback = function()
	vim.opt.syntax = "ruby"
	end,
})
