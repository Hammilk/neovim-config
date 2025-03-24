-- Keybindings (example)
-- Set Leader Key
vim.g.mapleader = " "

-- Telescope
local telescope = require("telescope.builtin")
local map = vim.keymap.set
local builtin = require("telescope.builtin")
map("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
map("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
map("n", "<leader>gs", builtin.git_status, { desc = "Git Status" })
map("n", "<leader>gc", builtin.git_commits, { desc = "Git Commits" })
map("n", "<leader>ss", builtin.lsp_document_symbols, { desc = "LSP Symbols" })
map("n", "<leader>fg", function()
	builtin.live_grep()
end, { desc = "Live Grep" })

-- Map keys for buffer navigation
vim.api.nvim_set_keymap("n", "<leader>bn", ":BufferLineCycleNext<CR>", { noremap = true, silent = true }) -- Next buffer
vim.api.nvim_set_keymap("n", "<leader>bp", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true }) -- Previous buffer

-- Debugging keymaps
vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end, { desc = "Debug: Start/Continue" })
vim.keymap.set("n", "<F10>", function()
	require("dap").step_over()
end, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F11>", function()
	require("dap").step_into()
end, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F12>", function()
	require("dap").step_out()
end, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<Leader>b", function()
	require("dap").toggle_breakpoint()
end, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<Leader>B", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Conditional Breakpoint" })
vim.keymap.set("n", "<Leader>dr", function()
	require("dap").repl.open()
end, { desc = "Debug: Open REPL" })
vim.keymap.set("n", "<Leader>du", function()
	require("dapui").toggle()
end, { desc = "Debug: Toggle UI" })

-- NvimTree keybindings (global)
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { noremap = true, silent = true, desc = "Focus file explorer" })
vim.keymap.set(
	"n",
	"<leader>r",
	":NvimTreeRefresh<CR>",
	{ noremap = true, silent = true, desc = "Refresh file explorer" }
)
