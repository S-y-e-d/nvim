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
    vim.api.nvim_command('write')  -- Save the file
    -- Determine the compile command based on file type
    if filetype == 'cpp' then
        cmd = 'g++ ' .. file .. ' -o ' .. file_no_ext .. nl .. './' .. file_no_ext .. rm
    elseif filetype == 'c' then
        cmd = 'gcc ' .. file .. ' -o ' .. file_no_ext .. nl .. './' .. file_no_ext .. rm
    elseif filetype == 'java' then
        cmd = 'javac ' .. file .. nl .. 'java ' .. file_no_ext .. ' ; rm *.class'
    elseif filetype == 'python' then
        cmd = 'python3 ' .. file
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
    vim.fn.feedkeys('i' .. cmd .. getkeycode('<CR><C-\\><C-n>'), 'n')
    -- Switch back to normal window?
    -- vim.defer_fn(function()
    --     vim.cmd('wincmd w')
    -- end, 100)
end
vim.api.nvim_set_keymap('n', '<leader>r', ':lua compile_and_run()<CR>', { noremap = true, silent = true })

function RefactorVariable()
    -- Go to the definition of the variable under the cursor.
    -- Disabled because JAVA does not respect variable scopes
    -- vim.cmd('normal! gd')
    
    -- Construct the substitution command
    local cmd = "::s/" .. vim.fn.expand('<cword>') .. "//g" .. getkeycode('<Left><Left>')
    -- Select the current block of code
    vim.cmd('normal! [{V%')
    
    -- Send the command to the command line
    vim.fn.feedkeys(cmd, 'n')
end
vim.api.nvim_set_keymap('n', 'gr', ':lua RefactorVariable()<CR>', { noremap = true, silent = true })

function telescope_local(mode)
    local cmd = {'fd', '.', '--max-depth', '2', '--type', 'f'}
    if mode == 1 then 
        cmd = {
            'find', '/home/syed/code', '/home/syed/Documents', '/home/syed/Downloads', '/home/syed/.config/nvim', 
            '-type', 'f', '-print'
        }
    end
    require('telescope').setup{
        pickers = {
            find_files = {
                hidden = true,
                find_command = cmd,
            },
        },
    }
    vim.cmd('Telescope find_files')
end
