return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- format on save
  cmd = { "Format", "FormatWrite" }, -- optional manual commands
  config = function()
    require("conform").setup({
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true, -- Use LSP formatting if no formatter is found
      },
      formatters_by_ft = {
        python = { "isort", "black" },
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        c = { "clang_format" },
        cpp = { "clang_format" },
      },
      formatters = {
        -- Optional: customize args if needed
        clang_format = {
          command = "clang-format",
          args = { "--style=LLVM" }, -- or "Google", "Chromium", etc.
        },
        prettier = {
          command = "prettier",
          args = { "--stdin-filepath", "$FILENAME" },
        },
      },
    })
  end,
}

