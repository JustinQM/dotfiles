return
{
	--mason
	{
		"williamboman/mason.nvim",
	},
	--mason_lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
	},
	--lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		init = function()
			require("mason").setup() --load mason
			require("mason-lspconfig").setup({ --load mason-lspconfig
				ensure_installed = {"lua_ls","clangd","pyright","bashls","html","marksman","powershell_es"}
			})
			local lsp = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			lsp.lua_ls.setup{capabilities = capabilities}
			lsp.clangd.setup{capabilities = capabilities}
			lsp.pyright.setup{capabilities = capabilities}
			lsp.bashls.setup{capabilities = capabilities}
			lsp.html.setup{capabilities = capabilities}
			lsp.marksman.setup{capabilities = capabilities}
			lsp.powershell_es.setup{capabilities = capabilities}
			lsp.gdshader_lsp.setup{capabilities = capabilities}
			lsp.gdscript.setup{capabilities = capabilities}

			--custom lsps
			local configs = require('lspconfig.configs')
			if not configs.c3_lsp then 
				configs.c3_lsp = {
					default_config = {
						cmd = {"/usr/local/bin/c3lsp"},
						filetypes = {"c3","c3i"},
						root_dir = function(fname)
						return require('lspconfig.util').find_git_ancestor(fname)
					end,
					settings = {},
					name = "c3_lsp"
					}	
				}
			end
			lsp.c3_lsp.setup{}
		end
	}
}
