return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "python", "javascript", "lua", "bash", "html", "css", "c", "cpp", "rust" },
                highlight = { enable = true },
            })
        end,
    },
}

