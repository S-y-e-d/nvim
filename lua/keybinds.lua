-- Use <Space> as the leader key
vim.g.mapleader = " "  -- Set the leader key to space

-- Comment lines
vim.api.nvim_set_keymap('n', '<leader>c', ':Commentary<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>c', ':Commentary<CR>', { noremap = true, silent = true })

-- Exit insert mode with 'jj'
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true, silent = true }) 

-- Quit all
vim.api.nvim_set_keymap('n', '<leader>q', ':qa<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>o', 'o<ESC>', { noremap = true, silent = true }) 
vim.api.nvim_set_keymap('n', '<leader>O', 'O<ESC>', { noremap = true, silent = true }) 

-- Find out more about a function
vim.api.nvim_set_keymap('n', '<leader>?', ":call CocAction('doHover')<CR>", { noremap = true, silent = true })

-- Use M to set a marker to a character, like Ma, then use ma to jump to that character
vim.api.nvim_set_keymap('n', 'm', '`', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'M', 'm', {noremap = true, silent = true})

-- Remap macro to tilde
vim.api.nvim_set_keymap('n', '`', '@', {noremap = true, silent = true})

-- Function to open terminal in the current directory
function OpenTermInDir()
  local dir = vim.fn.expand('%:h')  -- Get the current file's directory
  vim.cmd('ToggleTerm dir=' .. dir)  -- Open terminal in that directory
end

-- Map the function to a key
vim.api.nvim_set_keymap('n', '<leader>\\', ':lua OpenTermInDir()<CR>', { noremap = true, silent = true })

-- Telescope keybinds that run custom functions in functions.lua
vim.api.nvim_set_keymap('n', '<leader>f', ':lua telescope_local(0)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>F', ':lua telescope_local(1)<CR>', { noremap = true, silent = true })

-- Use UP and Down to cycle through items
vim.api.nvim_set_keymap('i', '<Down>', 'coc#pum#visible() ? coc#pum#next(1) : "\\<Tab>"', { expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Up>', 'coc#pum#visible() ? coc#pum#prev(1) : "\\<S-Tab>"', { expr = true, noremap = true, silent = true })

-- Use <Tab> to accept the current selection in the popup menu
vim.api.nvim_set_keymap('i', '<Tab>', 'coc#pum#visible() ? coc#pum#confirm() : "\\<Space>"', { expr = true, noremap = true, silent = true })

-- Remap shortcuts for terminal mode
vim.api.nvim_set_keymap('t', '<leader>r', '<C-\\><C-n>:lua OpenTermInDir()<CR>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('t', 'jj', '<C-\\><C-n>', {noremap = true, silent=true})

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

-- Paste from the yank/copy specific register
vim.api.nvim_set_keymap('n', '<leader>p', '"0p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>P', '"0P', { noremap = true, silent = true })

-- Split pane navigatoin
vim.api.nvim_set_keymap('n', '<leader>h', ':wincmd h<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', ':wincmd l<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', ':wincmd j<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', ':wincmd k<CR>', { noremap = true, silent = true })

-- Remapping to switch tabs
vim.api.nvim_set_keymap('n', '<leader>1', '1gt', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>2', '2gt', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>3', '3gt', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>4', '4gt', { noremap = true, silent = true })
