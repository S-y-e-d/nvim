-- Use <Space> as the leader key
vim.g.mapleader = " "  -- Set the leader key to space

-- NERDTree toggle
vim.api.nvim_set_keymap('n', '<leader>f', ':NERDTreeToggle %:p:h<CR>', { noremap = true, silent = true })

-- Comment lines
vim.api.nvim_set_keymap('n', '<leader>c', ':Commentary<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>c', ':Commentary<CR>', { noremap = true, silent = true })

-- Remove search highlighting
vim.api.nvim_set_keymap('n', '<leader><CR>', ':nohls<CR>', { noremap = true, silent = true })

-- Exit insert mode with 'jj'
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true, silent = true }) 

vim.api.nvim_set_keymap('n', '<leader>o', 'o<ESC>', { noremap = true, silent = true }) 
vim.api.nvim_set_keymap('n', '<leader>O', 'O<ESC>', { noremap = true, silent = true }) 

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
vim.api.nvim_set_keymap('n', '<leader>F', ':Telescope find_files<CR>', { noremap = true, silent = true })



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

-- Remapping all delete keys to the void register so that they don't override yanked lines
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

vim.api.nvim_set_keymap('n', '<leader>h', ':wincmd h<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', ':wincmd l<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', ':wincmd j<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', ':wincmd k<CR>', { noremap = true, silent = true })
