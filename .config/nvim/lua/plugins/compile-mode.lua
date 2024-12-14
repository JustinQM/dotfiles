return {
	"ej-shafran/compile-mode.nvim",
	branch = "latest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "m00qek/baleia.nvim", tag = "v1.3.0" },
	},
	opts = {
		default_command = ""
	},
	init = function()
		local opts = {noremap = true, silent = true}
		vim.api.nvim_set_keymap('n','<leader>CC',":Compile<CR>",opts) 
		vim.api.nvim_set_keymap('n','<leader>cc',":Recompile<CR>",opts) 
		vim.api.nvim_set_keymap('n','<leader>cn',":NextError<CR>",opts) 
		vim.api.nvim_set_keymap('n','<leader>cb',":PrevError<CR>",opts) 
	end,
	config = function()
    ---@type CompileModeOpts
    vim.g.compile_mode = {
        -- to add ANSI escape code support, add:
        baleia_setup = true,
    }
  end
}
