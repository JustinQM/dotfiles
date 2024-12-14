return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{ 
		"rafamadriz/friendly-snippets", --snippets used in luasnip
		lazy = true,
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{
		"saadparwaiz1/cmp_luasnip",
		lazy = true,
	},
	{
		'hrsh7th/cmp-buffer',
		lazy = true,
	},
	{
		'hrsh7th/cmp-path',
		lazy = true,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter", --load cmp when you enter insert mode
		dependencies  = {"L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip",'hrsh7th/cmp-buffer','hrsh7th/cmp-path','hrsh7th/cmp-cmdline'},
		opts = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			local luasnip = require("luasnip")
			local cmp = require("cmp")
				cmp.setup{
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = { --MAPPINGS START
					['<C-Space>'] = cmp.mapping.complete(),

					['<CR>'] = cmp.mapping(function(fallback)
						if cmp.visible() and cmp.get_active_entry() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({
									select = true,
								})
							end
						else
							fallback()
						end
					end),

					["<Tab>"] = cmp.mapping(function(fallback)
						if luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						elseif cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						elseif cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<A-j>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<A-k>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),

				}, --MAPPINGS END
				window = {
					completion = cmp.config.window.bordered({
							winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
					}),	
					documentation = cmp.config.window.bordered({
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
					}),
				},
				sources = {
					{ name = "path"},
					{ name = "nvim_lsp", max_item_count = 3, keyword_length = 1 },
					{ name = "buffer", max_item_count = 2, keyword_length = 3 },
					{ name = "luasnip", max_item_count = 1, keyword_length = 2},
				},
			}
		end,
	}
}
