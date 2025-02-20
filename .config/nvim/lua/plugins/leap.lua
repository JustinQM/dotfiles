return {
	{
		"ggandor/leap.nvim",
		dependencies = { "kylechui/nvim-surround","tpope/vim-repeat" },
		event = "VeryLazy",
		init = function()
			require("leap").create_default_mappings()
		end,
	}
}
