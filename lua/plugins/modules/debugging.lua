return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"mfussenegger/nvim-dap-python",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup dap-ui
			dapui.setup()

			-- Automatically open/close dap-ui when session starts/stops
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Virtual text for inline variable display
			require("nvim-dap-virtual-text").setup()

			-- Python debugger
			require("dap-python").setup(vim.fn.expand("~/.virtualenvs/debugpy/bin/python"))

			-- Optional: Fix line number issue when debugging
			vim.api.nvim_create_autocmd("User", {
				pattern = { "DapSessionStart", "DapSessionStopped" },
				callback = function()
					vim.wo.number = true
					vim.wo.relativenumber = true
				end,
			})
		end,
	},
}
