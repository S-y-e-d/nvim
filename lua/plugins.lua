
-- Plugin manager setup (using vim-plug)
vim.call('plug#begin', '~/.config/nvim/plugged')  -- Start the plugin manager

-- Plugins
vim.call('plug#', 'preservim/nerdtree')                           -- File explorer
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
vim.call('plug#end')  -- End the plugin manager setup                                                                               
--
--
-- Enable coc.nvim Autocomplete
vim.g.coc_global_extensions = {
  'coc-snippets',
  'coc-tsserver',
  'coc-html',
  'coc-css',
  'coc-json',
  'coc-pyright',
  'coc-clangd'
}

require'toggleterm'.setup{
    size = 60,                  -- The size of the terminal. Only works for vertical and horizontal types
    hide_numbers = true,        -- Hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 1,         -- the degree by which to darken the terminal color
    start_in_insert = false,
    insert_mappings = true,    -- default mappings that work in ide work in term or not
    terminal_mappings = true,
    persist_size = true,
    direction = 'vertical',     -- 'vertical' or 'horizontal' | 'float' opens in a floating window
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
}

require('cyberdream').setup({
    transparent=true,
    italic_comments=true,
    borderless_telescope=false,
    terminal_colors = true,
})

require('lualine').setup{
    options = {
        theme = 'powerline_dark',
    },
}
