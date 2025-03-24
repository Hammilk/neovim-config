return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-ui-select.nvim",
	},
	opts = function(_, opts)
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
			prompt_prefix = "   ",
			selection_caret = " ",
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				},
			},
		})

		opts.pickers = {
			find_files = {
				hidden = true,
			},
		}

		opts.extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
		}

		telescope.setup(opts)

		-- Load extensions
		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
	end,
}
