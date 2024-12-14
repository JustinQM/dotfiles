return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function () 
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = { "c","lua","vimdoc"},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },  
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = false, -- set to `false` to disable one of the mappings
					node_incremental = "tn",
					scope_incremental = "ts",
					node_decremental = "tb",
				},
			},
		})
		local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
		parser_config.c3 = {
			install_info = {
				url = "https://github.com/c3lang/tree-sitter-c3",
				files = {"src/parser.c", "src/scanner.c"},
				branch = "main",
			},
		}
		end
	}
}
