vim.opt.rtp:prepend(vim.fn.stdpath('config') .. '/lua/lazy')

require('plugins.plugins')
require('settings.settings')
require('mappings.mappings')


