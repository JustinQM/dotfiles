return
{
	{
		"salkin-mada/openscad.nvim",
		lazy = true,
		event = "BufRead *.scad",
		config = function()
			require('openscad').setup()
			vim.g.openscad_load_snippets = true
			vim.g.openscad_default_mappings = true
		end,
	}
}
