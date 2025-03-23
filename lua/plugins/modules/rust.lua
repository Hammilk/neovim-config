return {
    {
        "simrat39/rust-tools.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("rust-tools").setup({
                server = {
                    on_attach = function(_, bufnr)
                        local opts = { noremap = true, silent = true }
                        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>l", "<cmd>RustRunnables<CR>", opts)
                    end,
                },
            })
        end,
    },
}

