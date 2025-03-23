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
    {'hrsh7th/cmp-cmdline'}, -- Command line completions
    {'L3MON4D3/LuaSnip'},  -- Snippet engine
    {'saadparwaiz1/cmp_luasnip'}, -- Snippet completion source
    {'nvim-lualine/lualine.nvim'}, -- Statusline plugin
    {'onsails/lspkind-nvim'}, -- LSP kind plugin
    {'kyazdani42/nvim-tree.lua',  -- File explorer
        requires = {'nvim-tree/nvim-web-devicons'}, -- Optional, for file icons
        config = function()
            require('nvim-tree').setup {
                -- Your custom configuration here
            }
        end
    },
    {'akinsho/bufferline.nvim'}, -- Bufferline
    {'nvim-telescope/telescope.nvim',
        dependencies = { {'nvim-lua/plenary.nvim'} },
        config = function()
            require('telescope').setup{}
        end
    },
    {'mfussenegger/nvim-dap'},
})




-- Initialize lspkind for pretty formatting of completion items
local lspkind = require('lspkind')
lspkind.init()

-- Setup nvim-cmp
local cmp = require'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
    formatting = {
        format = lspkind.cmp_format({ with_text = true, maxwidth = 50 }),
    },
})

-- Setup bufferline
require('bufferline').setup {
    options = {
        numbers = "buffer_id",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        indicator_icon = '▎',
        buffer_close_icon = '',
        modified_icon = '✥',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 21,
        diagnostics = false,
        offsets = {{ filetype = "NvimTree", text = "File Explorer", text_align = "center", separator = true }},
    }
}

vim.cmd('colorscheme neon')

-- LSP settings
local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Python LSP
lspconfig.pyright.setup{}

-- Rust LSP setup
lspconfig.rust_analyzer.setup{
    capabilities = lsp_capabilities,
    on_attach = function(_, bufnr)
        -- Set up key mappings for Rust
        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>r", "<cmd>RustRun<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>l", "<cmd>RustRunnables<CR>", opts)
    end,
}

-- Treesitter configuration
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "python", "javascript", "lua", "bash", "html", "css", "c", "cpp", "rust" },
    highlight = {
        enable = true,
    },
}

-- Lualine setup
require('lualine').setup {
    options = {
        theme = 'neon',
    }
}

-- nvim-tree configuration
require'nvim-tree'.setup {
    view = {
        width = 30,
        side = 'left',
    },
}

-- Keybinding for NvimTree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

