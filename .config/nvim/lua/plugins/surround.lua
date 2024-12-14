return 
{
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		init = function()
			require("nvim-surround").setup({
				keymaps = {
					keymaps = {
						insert = "<C-g>ys",
						insert_line = "<C-g>yS",
						normal = "ys",
						normal_cur = "yss",
						normal_line = "yS",
						normal_cur_line = "ySS",
						visual = "yS",
						visual_line = "ygS",
						delete = "ds",
						change = "cs",
						change_line = "cS",
					},

				},
			})
		end,
	}
}


