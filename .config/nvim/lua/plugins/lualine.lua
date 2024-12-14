return {
	{
		'nvim-lualine/lualine.nvim',
		event = "VeryLazy",
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		options = {
			theme = 'auto',
		},
		init = function()
			require("lualine").setup()
		end,
	}
}
