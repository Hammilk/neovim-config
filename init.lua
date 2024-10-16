-- Load Packer and ensure it is installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand to reload Neovim when you save the plugins file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

-- Use Packer for managing plugins
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself

 -- Themes
  use 'morhetz/gruvbox'            -- Gruvbox theme
  use 'shaunsingh/nord.nvim'       -- Nord theme
  use 'rafamadriz/neon'
  -- Add your plugins here
  use 'nvim-treesitter/nvim-treesitter'  -- Treesitter for syntax highlighting
  use 'neovim/nvim-lspconfig'  -- LSP (Language Server Protocol) for autocompletion, diagnostics, etc.
  use 'hrsh7th/nvim-cmp'  -- Completion plugin
  use 'hrsh7th/cmp-nvim-lsp'  -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-buffer' -- Buffer Completions
  use 'hrsh7th/cmp-path' -- Path Completions
  use 'hrsh7th/cmp-cmdline' --Command line completions
  use 'L3MON4D3/LuaSnip'  -- Snippet engine
  use 'saadparwaiz1/cmp_luasnip' -- Snippet completion source
  use 'nvim-lualine/lualine.nvim' -- Statusline plugin
  use 'onsails/lspkind-nvim' -- lsp kind plugin
  use 'kyazdani42/nvim-tree.lua' -- file tree
  use 'akinsho/bufferline.nvim' -- bufferline

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)

local lspkind = require('lspkind')
lspkind.init()


-- Set up nvim-cmp for autocomplete
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      -- You need a snippet engine for this to work; here we're using luasnip.
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  },
  formatting = {
    format = require('lspkind').cmp_format({with_text = true, maxwidth = 50})
  }
})

--Bufferline Set up

require('bufferline').setup {
    options = {
        numbers = "buffer_id",
        close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        indicator_icon = '▎',
        buffer_close_icon = '',
        modified_icon = '✥',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 21,
        diagnostics = false, -- can be "nvim_lsp", "nvim_lsp_error", "nvim_lsp_warning", "nvim_lsp_information" or "nvim_lsp_hint"
        offsets = {{ filetype = "NvimTree", text = "File Explorer", text_align = "center", separator = true }},
    }
}


vim.cmd('colorscheme neon') --Set the theme


-- nvim-cmp configuration (for autocompletion)
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
})

-- LSP settings (configuring built-in language servers)
local lspconfig = require('lspconfig')

lspconfig.pyright.setup{}  -- Python LSP
lspconfig.rust_analyzer.setup{} -- Rust LSP

-- Treesitter configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "javascript", "lua", "bash", "html", "css", "c", "cpp" },  -- List the languages you want parsers for
  highlight = {
    enable = true,
  },
}

lspconfig.clangd.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "clangd" },
    filetypes = { "c", "cpp" },
    root_dir = require'lspconfig'.util.root_pattern("compile_commands.json", ".git"),
}


-- Lualine setup (for statusline)
require('lualine').setup {
  options = {
    theme = 'neon'
  }
}

-- nvim-tree configuration
require'nvim-tree'.setup {
        view = {
        width = 30,   -- width of the file tree
        side = 'left', -- position of the file tree (left or right)
    },
}


vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })


-- General settings
vim.opt.number = true  -- Show line numbers
vim.opt.relativenumber = true  -- Show relative line numbers
vim.opt.tabstop = 4  -- Number of spaces for a tab
vim.opt.shiftwidth = 4  -- Number of spaces to use for each indentation
vim.opt.expandtab = true  -- Convert tabs to spaces
vim.opt.smartindent = true  -- Automatically indent new lines
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Override ignore case if search ontains uppercase letters

-- Keybindings (example)
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':terminal<CR>', { noremap = true, silent = true })
-- Map keys for buffer navigation
vim.api.nvim_set_keymap('n', '<leader>bn', ':BufferLineCycleNext<CR>', { noremap = true, silent = true }) -- Next buffer
vim.api.nvim_set_keymap('n', '<leader>bp', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true }) -- Previous buffer




