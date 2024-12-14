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
		end,
	}
}
