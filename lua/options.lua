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
-- vim.o.scrolloff = 999            -- Use this to keep cursor centered
vim.o.wrap = true                   -- Enable line wrapping
vim.cmd('syntax enable')            -- Enable syntax highlighting
vim.cmd('filetype plugin indent on') -- Enable filetype detection and plugins

-- Set the color columns as a solid block instead of line
-- local columns = ""
-- for i=101,240,1 do
    -- columns = columns .. i .. ","
-- end
-- vim.opt.colorcolumn = string.sub(columns, 1, -2)
vim.opt.colorcolumn = '100'

-- Colorscheme
vim.o.termguicolors = true          -- Enable true colors
vim.cmd('colorscheme cyberdream')      -- Set colorscheme

vim.o.autochdir = true -- Automatically change the current working directory to current file dir.
vim.o.splitright = true -- Split the window to the right vertically

-- Remember cursor position when reopening files
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, {row, col})
    end
  end
})
