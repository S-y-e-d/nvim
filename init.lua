-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true 

-- Mouse support 
vim.o.mouse = 'a'

-- Clipboard
vim.o.clipboard = 'unnamedplus'

-- Tab configuration
vim.o.tabstop = 4                   -- Number of spaces tabs count for
vim.o.shiftwidth = 4                -- Number of spaces to use for each step of (auto)indent
vim.o.expandtab = true              -- Use spaces instead of tabs

-- Other settings
-- vim.o.scrolloff = 999
vim.o.wrap = true                   -- Enable line wrapping
vim.cmd('syntax enable')            -- Enable syntax highlighting
vim.cmd('filetype plugin indent on') -- Enable filetype detection and plugins

-- Set the color columns
local columns = ""
for i=101,240,1 do
    columns = columns .. i .. ","
end
vim.opt.colorcolumn = string.sub(columns, 1, -2)

-- Colorscheme
vim.o.termguicolors = true          -- Enable true colors
vim.cmd('colorscheme monokai')      -- Set colorscheme

-- Monokai specific settings
-- Function to update highlight options while keeping existing settings
local function set_highlight(group, opts)
    local current_hl = vim.api.nvim_get_hl(0, { name = group })  -- Get current highlight options
    local new_hl = vim.tbl_extend('force', current_hl, opts)    -- Merge with new options
    vim.api.nvim_set_hl(0, group, new_hl)                       -- Set the highlight group
end
set_highlight('Function', { italic = true })
-- set_highlight('NonText', { bg = '#ffffff'})
-- set_highlight('Normal', { bg = 'NONE'})

-- Plugin manager setup (using vim-plug)
vim.call('plug#begin', '~/.config/nvim/plugged')  -- Start the plugin manager

-- Plugins
vim.call('plug#', 'preservim/nerdtree')                           -- File explorer
vim.call('plug#', 'neoclide/coc.nvim', { branch = 'release' })   -- Autocomplete
vim.call('plug#', 'neovim/nvim-lspconfig')                         -- LSP
vim.call('plug#', 'akinsho/nvim-toggleterm.lua')                   -- Terminals
vim.call('plug#', 'tpope/vim-commentary')                          -- Easy comment lines
vim.call('plug#', 'editorconfig/editorconfig-vim')                 -- To read local config files for formatting etc.
vim.call('plug#', 'nvim-lua/plenary.nvim')                         -- Telescope dependency
vim.call('plug#', 'nvim-telescope/telescope.nvim')                 -- To fuzzy search and open files

vim.call('plug#end')  -- End the plugin manager setup                                                                               
-- Use <Space> as the leader key
vim.g.mapleader = " "  -- Set the leader key to space

-- NERDTree toggle
vim.api.nvim_set_keymap('n', '<leader>f', ':NERDTreeToggle %:p:h<CR>', { noremap = true, silent = true })

-- Comment lines
vim.api.nvim_set_keymap('n', '<leader>c', ':Commentary<CR>', { noremap = true, silent = true })

-- Remove search highlighting
vim.api.nvim_set_keymap('n', '<leader><CR>', ':nohls<CR>', { noremap = true, silent = true })

-- Exit insert mode with 'jj'
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true, silent = true }) 

vim.api.nvim_set_keymap('n', '<leader>o', 'o<ESC>k', { noremap = true, silent = true }) 
vim.api.nvim_set_keymap('n', '<leader>O', 'O<ESC>j', { noremap = true, silent = true }) 

-- Function to open terminal in the current directory
function OpenTermInDir()
  local dir = vim.fn.expand('%:h')  -- Get the current file's directory
  vim.cmd('ToggleTerm dir=' .. dir)  -- Open terminal in that directory
end

-- Map the function to a key
vim.api.nvim_set_keymap('n', '<leader>\\', ':lua OpenTermInDir()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>F', ':Telescope find_files<CR>', { noremap = true, silent = true })


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

-- Use <Tab> for trigger completion and <S-Tab> for cycling through completion items
vim.api.nvim_set_keymap('i', '<Tab>', 'coc#pum#visible() ? coc#pum#next(1) : "\\<Tab>"', { expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'coc#pum#visible() ? coc#pum#prev(1) : "\\<S-Tab>"', { expr = true, noremap = true, silent = true })

-- Use <Enter> to accept the current selection in the popup menu
vim.api.nvim_set_keymap('i', '<CR>', 'coc#pum#visible() ? coc#pum#confirm() : "\\<CR>"', { expr = true, noremap = true, silent = true })

-- Remap <C-w>w to switch windows in terminal mode
vim.api.nvim_set_keymap('t', '<C-w><C-w>', '<C-\\><C-n><C-w>w', { noremap = true, silent = true })

-- Use <Tab> for jumping to the next snippet placeholder
vim.g.coc_snippet_next = '<Tab>'

-- Use <S-Tab> for jumping to the previous snippet placeholder
vim.g.coc_snippet_prev = '<S-Tab>'

-- Brace on new line for specific file types
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "java" },
    callback = function()
        vim.opt_local.cinoptions = "{0,g0"
    end,
})

function getkeycode(string)
    return vim.api.nvim_replace_termcodes(string, true, true, true)
end

function is_toggleterm_active()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win)):match("toggleterm") then
            return true
        end
    end
    return false
end

function compile_and_run()
    local file = vim.fn.expand('%:p:t')  -- Get the current filename with extension
    local file_no_ext = vim.fn.expand('%:p:t:r')  -- Get the current filename without extension
    local dir = vim.fn.expand('%:h')
    local filetype = vim.bo.filetype  -- Get the current file type
    local cmd = ''
    local nl = ' && echo "" && '
    local rm = ' ; rm ' .. file_no_ext
    -- Determine the compile command based on file type
    if filetype == 'cpp' then
        cmd = 'g++ ' .. file .. ' -o ' .. file_no_ext .. nl .. './' .. file_no_ext .. rm
    elseif filetype == 'c' then
        cmd = 'gcc ' .. file .. ' -o ' .. file_no_ext .. nl .. './' .. file_no_ext .. rm
    elseif filetype == 'java' then
        cmd = 'javac ' .. file .. nl .. 'java ' .. file_no_ext .. ' ; rm *.class'
    else
        print("Unsupported file type: " .. filetype)
        return
    end
    -- Check if a terminal is open
    if not is_toggleterm_active() then
        -- Open a terminal if it's not open
        vim.cmd('ToggleTerm dir=' .. dir)
        print("Opening a terminal")
    else
        -- If terminal is open, switch to it
        vim.cmd('wincmd w')
        print("switcing to terminal")
    end
    -- Send the command to the terminal
    vim.fn.feedkeys('i' .. cmd .. getkeycode('<CR>'), 'n')
end
vim.api.nvim_set_keymap('n', '<leader>r', ':lua compile_and_run()<CR>', { noremap = true, silent = true })

function RefactorVariable()
    -- Go to the definition of the variable under the cursor
    vim.cmd('normal! gd')
    
    -- Construct the substitution command
    local cmd = "::s/" .. vim.fn.expand('<cword>') .. "//g" .. getkeycode('<Left><Left>')
    -- Select the current block of code
    vim.cmd('normal! [{V%')
    
    -- Send the command to the command line
    vim.fn.feedkeys(cmd, 'n')
end
vim.api.nvim_set_keymap('n', 'gr', ':lua RefactorVariable()<CR>', { noremap = true, silent = true })



require'toggleterm'.setup{
    size = 60,                  -- The size of the terminal. Only works for vertical and horizontal types
    hide_numbers = true,        -- Hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 1,         -- the degree by which to darken the terminal color
    start_in_insert = false,
    insert_mappings = false,    -- default mappings that work in ide work in term or not
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
                'find', './.config', './code', './Documents', './Downloads',
                '-type', 'f', '-print'
            },
        },
    },
}


-- Remapping all delete keys to the void register so that they don't override yanked lines

-- print(string.char(65))
function mapAllChars(cmd)
    for ascii = 32, 126, 1 do
        local new_cmd = cmd .. string.char(ascii)
        vim.api.nvim_set_keymap('n', new_cmd, '"_' .. new_cmd, { noremap = true, silent = true })
    end
end

local commands = {
    'dd', 'D', 'diw', 'di(', 'di{', 'di[', "di'", 'di"', 'daw', 'dw', 'dW', 'd0', 'd$',
    'cc', 'C', 'ciw', 'ci(', 'ci{', 'ci[', "ci'", 'ci"', 'caw', 'cw', 'cW', 'c0', 'c$'
}
for _, cmd in ipairs(commands) do
    vim.api.nvim_set_keymap('n', cmd, '"_' .. cmd, { noremap = true, silent = true })
end

commands = {
    'dt', 'ct', 'dT', 'cT'
}

for _, cmd in ipairs(commands) do
    mapAllChars(cmd)
end

vim.api.nvim_set_keymap('n', '<leader>d', 'dd', { noremap = true, silent = true })
