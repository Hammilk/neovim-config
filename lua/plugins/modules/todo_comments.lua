return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },

		opts = {
			signs = true, -- Show icons in the sign column
			sign_priority = 8, -- Sign priority
			keywords = {
				FIX = {
					icon = " ", -- Icon used for the sign and in search results
					color = "error", -- Can be a hex color or a named color
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- Alternative keywords
				},
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
		},

		config = function(_, opts)
			require("todo-comments").setup(opts)
		end,
		event = "BufReadPost", -- Load the plugin after opening a file
	},
}
