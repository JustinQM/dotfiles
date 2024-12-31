return {
	{
		"junegunn/vim-easy-align",
		event = "VeryLazy",
		config = function()
			local opts = {noremap = true, silent = true}
			vim.api.nvim_set_keymap('n','ga',":EasyAlign",opts) 
			vim.api.nvim_set_keymap('v','ga',":EasyAlign",opts) 
		end,
	}
}
