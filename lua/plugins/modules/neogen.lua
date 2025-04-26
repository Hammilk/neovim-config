return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = true,
  keys = {
    {
      "<Leader>d",
      function()
        require("neogen").generate()
      end,
      desc = "Generate docstring",
    },
  },
}

