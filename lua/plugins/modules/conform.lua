-- ~/.config/nvim/lua/plugins/conform.lua
return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo", "Format", "FormatWrite" }, -- load on command
	event = { "BufWritePre" }, -- or BufReadPre if you want it earlier
	config = function()
		require("conform").setup({
			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				python = { "black", "isort" },
			},
		})
	end,
}
