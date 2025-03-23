-- init.lua
require('lazy').setup({
	-- Themes
    {'morhetz/gruvbox'},            -- Gruvbox theme
	{'shaunsingh/nord.nvim'},       -- Nord theme
	{'rafamadriz/neon'},
  	-- Add your plugins here
	{'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},  -- Treesitter for syntax highlighting
    {"simrat39/rust-tools.nvim",
        config = function()
            require("rust-tools").setup({
                server = {
                    on_attach = function(_, bufnr)
                        -- Set up key mappings
                        local opts = { noremap = true, silent = true }
                        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>r", "<cmd>RustRun<CR>", opts)
                        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>l", "<cmd>RustRunnables<CR>", opts)
                    end,
                },
            })
        end,
    },
	{'neovim/nvim-lspconfig'},  -- LSP (Language Server Protocol) for autocompletion, diagnostics, etc.
	{'hrsh7th/nvim-cmp'},  -- Completion plugin
	{'hrsh7th/cmp-nvim-lsp'},  -- LSP source for nvim-cmp
	{'hrsh7th/cmp-buffer'}, -- Buffer Completions
	{'hrsh7th/cmp-path'}, -- Path Completions
    {'hrsh7th/cmp-cmdline'}, --Command line completions
    {'L3MON4D3/LuaSnip'},  -- Snippet engine
    {'saadparwaiz1/cmp_luasnip'}, -- Snippet completion source
    {'nvim-lualine/lualine.nvim'}, -- Statusline plugin
    {'onsails/lspkind-nvim'}, -- lsp kind plugin
	{'kyazdani42/nvim-tree.lua',                -- Ensure you have the correct repository name
	        requires = {'nvim-tree/nvim-web-devicons'}, -- Optional, for file icons
	        config = function()
	            require('nvim-tree').setup {
	                -- Your custom configuration here
	                -- e.g. open_on_setup = false
	            }
	        end
	    },
    {'akinsho/bufferline.nvim'}, -- bufferline
    {'nvim-telescope/telescope.nvim',
        dependencies = { {'nvim-lua/plenary.nvim'} },
        config = function()
            require('telescope').setup{
            }
        end
    },
})

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

--local capabilities = cmp_lsp.default_capabilities()

lspconfig.pyright.setup{}  -- Python LSP
lspconfig.rust_analyzer.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "rs"},
    root_dir = require'lspconfig'.util.root_pattern("compile_commands.json", ".git"),
} -- Rust LSP

-- Treesitter configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "javascript", "lua", "bash", "html", "css", "c", "cpp", "rust" },  -- List the languages you want parsers for
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






