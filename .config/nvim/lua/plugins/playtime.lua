return 
{
	{
		'rktjmp/playtime.nvim',
		lazy = false,

		init = function ()
		--fix cyan since my configs color's cyan is too close to blue
		vim.api.nvim_set_hl(0, 'PlaytimeCyan', { fg = "#0096FF"})

		--add some keybinds
		vim.keymap.set('n', '<leader>pss', '<CMD>Playtime shenzhen-solitaire<CR>')
		vim.keymap.set('n', '<leader>pt', '<CMD>Playtime<CR>')

		end
	}
}
