
-- ───────────────────────────────────────────────────────
-- Leader key must be set *before* loading lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ───────────────────────────────────────────────────────
-- Bootstrap lazy.nvim if it's not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ───────────────────────────────────────────────────────
-- Load plugins (uses import = "plugins.modules" to load all modular files)
require("plugins.plugins")

-- ───────────────────────────────────────────────────────
-- Load settings and keybindings
require("settings.settings")
require("mappings.mappings")

-- ───────────────────────────────────────────────────────
-- (Optional) Set your default colorscheme here
vim.cmd.colorscheme("neon")
