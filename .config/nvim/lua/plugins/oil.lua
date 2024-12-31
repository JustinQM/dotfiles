return {
	{
		'stevearc/oil.nvim',
		lazy = false,
		opts = {
			skip_confirm_for_simple_edits = true,
			watch_for_changes = true
		},

		--defaults but here for refrence
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["<C-s>"] = "actions.select_vsplit",
			["<C-h>"] = "actions.select_split",
			["<C-t>"] = "actions.select_tab",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
			["<C-l>"] = "actions.refresh",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["~"] = "actions.tcd",
			["gs"] = "actions.change_sort",
			["gx"] = "actions.open_external",
			["g."] = "actions.toggle_hidden",
			["g\\"] = "actions.toggle_trash",
		},

		--optional
		dependencies = { "nvim-tree/nvim-web-devicons" },
		init=function()
			--set keymap
			local opts = {noremap = true, silent = true}
			vim.api.nvim_set_keymap('n', '<leader>e', [[:Oil<cr>]], opts)
		end,
	}
}
