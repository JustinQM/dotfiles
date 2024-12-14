return {
	{
		"ggandor/leap.nvim",
		dependencies = { "kylechui/nvim-surround" },
		event = "VeryLazy",
		init = function()
			require("leap").create_default_mappings()
		end,
	}
}
