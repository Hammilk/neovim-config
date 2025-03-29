return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("settings.diagnostics")
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Python LSP
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})
		end,
	},
}
