return
{
	{
		"tpope/vim-fugitive",
		opts = {},
		cmd = "Git",
		lazy = false,
		config = function()
			local opts = {noremap = true, silent = true}
			vim.api.nvim_set_keymap('n','<leader>gg',":0G<CR>",opts) 
			vim.api.nvim_set_keymap('n','<leader>gd',":Gvdiffsplit!<CR>",opts) 
			vim.api.nvim_set_keymap('n','<leader>gl',":G log<CR>",opts) 
		end,
	}
}
