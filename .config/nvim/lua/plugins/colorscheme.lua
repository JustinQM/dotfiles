return {
  -- kanagawa
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
		overrides = function(colors)
			return {
				Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
				PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
				PmenuSbar = { bg = theme.ui.bg_m1 },
				PmenuThumb = { bg = theme.ui.bg_p2 },
			}
		end
    end,
  },
  {
	"loctvl842/monokai-pro.nvim",
	priority = 1000,
	init = function ()
		require("monokai-pro").setup({
			override = function ()
				return {
					Directory = { bg = "NONE", fg = "#8ab3ff"}
				}
			end
		})
	end
  }
}
