return {
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({ options = { theme = "neon" } })
        end,
    },
    {
        "akinsho/bufferline.nvim",
        config = function()
            require("bufferline").setup({
                options = {
                    offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
                },
            })
        end,
    },
}

