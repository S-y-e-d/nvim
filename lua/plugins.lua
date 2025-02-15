
-- Plugin manager setup (using vim-plug)
vim.call('plug#begin', '~/.config/nvim/plugged')  -- Start the plugin manager

-- Plugins
vim.call('plug#', 'neoclide/coc.nvim', { branch = 'release' })    -- Autocomplete
vim.call('plug#', 'neovim/nvim-lspconfig')                        -- LSP
vim.call('plug#', 'akinsho/nvim-toggleterm.lua')                  -- Terminals
vim.call('plug#', 'tpope/vim-commentary')                         -- Easy comment lines
vim.call('plug#', 'editorconfig/editorconfig-vim')                -- To read local config files for formatting etc.
vim.call('plug#', 'nvim-lua/plenary.nvim')                        -- Telescope dependency
vim.call('plug#', 'nvim-telescope/telescope.nvim')                -- To fuzzy search and open files
vim.call('plug#', 'scottmckendry/cyberdream.nvim')                -- Cyberdream theme
vim.call('plug#', 'nvim-lualine/lualine.nvim')                    -- Status Line
vim.call('plug#', 'nvim-tree/nvim-web-devicons')                  -- Icons for status line
vim.call('plug#', 'windwp/nvim-autopairs')                        -- Auto pairing plugin
vim.call('plug#', 'nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
vim.call('plug#end')  -- End the plugin manager setup                                                                               


-- Enable coc.nvim Autocomplete
vim.g.coc_global_extensions = {
  'coc-snippets',
  'coc-tsserver',
  'coc-html',
  'coc-css',
  'coc-json',
  'coc-pyright',
  'coc-clangd',
}

require('nvim-treesitter.configs').setup {
  ensure_installed = { "cpp", "lua", "python", "rust" }, -- Add more if needed
  highlight = { enable = true },
  indent = { enable = true },
}

require("nvim-autopairs").setup({
  check_ts = true, -- Enable Treesitter support
  map_cr = true,   -- Auto-indent on Enter inside {}
})

require'toggleterm'.setup{
    size = 45,                  -- The size of the terminal. Only works for vertical and horizontal types
    hide_numbers = true,        -- Hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 1,         -- the degree by which to darken the terminal color
    start_in_insert = false,
    insert_mappings = true,    -- default mappings that work in ide work in term or not
    terminal_mappings = true,
    persist_size = true,
    direction = 'float',     -- 'vertical' or 'horizontal' | 'float' opens in a floating window
}



vim.diagnostic.config({
    virtual_text = true,
})

vim.opt.completeopt:append({ "menuone", "noselect" })    -- Enable autocomplete

local lspconfig = require('lspconfig')
lspconfig.clangd.setup{
    cmd = { "clangd", "--background-index" },
}

require('telescope').setup{
    pickers = {
        find_files = {
            hidden = true,
            find_command = {
                'find', '/home/syed/code', '/home/syed/Documents', '/home/syed/Downloads', '/home/syed/.config/nvim', 
                '-type', 'f', '-print'
            },
        },
    },
    defaults = {
        initial_mode = 'normal',
        sorting_strategy='descending',
        path_display = { "filename_first" },
        mappings = {
            i = { -- for insert mode
                ["<leader>t"] = require('telescope.actions').select_tab,
                ["<leader>s"] = require('telescope.actions').select_vertical,
            },
            n = { -- for normal mode
                ["<leader>t"] = require('telescope.actions').select_tab,
                ["<leader>s"] = require('telescope.actions').select_vertical,
            },
        }
    }
}

require('cyberdream').setup({
    transparent=true,
    italic_comments=true,
    terminal_colors = true,
})

require('lualine').setup{
    options = {
        theme = 'powerline_dark',
    },
}
