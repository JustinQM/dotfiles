return {
	{ 
		'nvim-telescope/telescope-fzf-native.nvim', 
		build = 'make',
		lazy = false,
	},
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		dependencies = { 'nvim-lua/plenary.nvim' },
		event = "VeryLazy",
		init = function()
			require('telescope').setup{
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					}
				}
			}
			require('telescope').load_extension('fzf')
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		end,
	}
}
