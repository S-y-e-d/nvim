set number                                                                          " Line numbers
set relativenumber

set mouse=a                                                                         " Mouse support

set clipboard+=unnamedplus

set tabstop=4                                                                       " Tab config
set shiftwidth=4
set expandtab

set wrap
syntax enable
filetype plugin indent on

colorscheme monokai
set termguicolors
let g:monokai_term_italic = 1
highlight Function gui=italic
hi Normal guibg=NONE ctermbg=NONE                                                   " Transparent Background
hi NonText guibg=NONE ctermbg=NONE
                                                                                
call plug#begin()                                                                   " Plugins

Plug 'preservim/nerdtree'                                                           " File explorer
Plug 'neoclide/coc.nvim', {'branch': 'release'}                                     " Autocomplete
Plug 'neovim/nvim-lspconfig'                                                        " LSP
Plug 'akinsho/nvim-toggleterm.lua'                                                  " Terminals
Plug 'tpope/vim-commentary'                                                         " Easy comment lines
Plug 'editorconfig/editorconfig-vim'                                                " To read local config files for formatting etc.
Plug 'nvim-lua/plenary.nvim'                                                        " Telescope dependency
Plug 'nvim-telescope/telescope.nvim'                                                " To fuzzy search and open files

call plug#end()
                                                                                    " Comments on different line because it breaks
                                                                                    " Use <Space> as the leader key
let mapleader = "\<Space>"
                                                                                    " NERDTree toggle
nnoremap <leader>f :NERDTreeToggle %:p:h<CR>
                                                                                    " Comment lines
nnoremap <leader>c :Commentary<CR>
                                                                                    " Remove Search highlighting
nnoremap <leader><CR> :nohls<CR>
                                                                                    " Exit insert mode
inoremap jj <ESC>
                                                                                    " Used to insert new line in normal mode
nnoremap oo o<ESC>
nnoremap OO O<ESC>

function! OpenTermInDir()                                                           " Function to open terminal in current directory
  let l:dir = expand('%:h')
  exe 'ToggleTerm dir=' . l:dir
endfunction
nnoremap <leader>\ :call OpenTermInDir()<CR>
                                                                                    " Fuzzy search
nnoremap <leader>F :Telescope find_files<CR>
" Enable coc.nvim                                                                     Autocomplete
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-json',
  \ 'coc-pyright',
  \ 'coc-clangd'
  \ ]

" Use <Tab> for trigger completion and <S-Tab> for cycling through completion items
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Use <Enter> to accept the current selection in the popup menu
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
" Remap <C-w>w to switch windows in terminal mode
tnoremap <C-w><C-w> <C-\><C-n><C-w>w

" Use <Tab> for jumping to the next snippet placeholder
let g:coc_snippet_next = '<Tab>'

" Use <S-Tab> for jumping to the previous snippet placeholder
let g:coc_snippet_prev = '<S-Tab>'

" Brace on new line
autocmd FileType c,cpp,java setlocal cinoptions={0,g0

function! CompileAndRunJava()
    let l:file = expand('%:p')  " Get the current filename with extension
    let l:file_no_ext = expand('%:p:r')  " Get the current filename without extension
    let l:cmd = 'javac ' . l:file . ' && echo "" && java ' . l:file_no_ext . ' && rm *.class'

    " Check if a terminal is open
    if empty(filter(range(1, bufnr('$')), 'getbufvar(v:val, "&filetype") == "toggleterm"'))
        " Open a terminal if it's not open
        exe 'ToggleTerm'
    else
        " If terminal is open, switch to it
        exe 'wincmd w'
    endif

    " Send the command to the terminal
    call feedkeys("i" . l:cmd . "\<CR>\<c-w>\<c-w>")
endfunction

function! CompileAndRunCpp()
    let l:file = expand('%:p')  " Get the current filename with extension
    let l:file_no_ext = expand('%:p:r')  " Get the current filename without extension
    let l:dir = expand('%:h')
    let l:cmd = 'g++ ' . l:file . ' -o ' . l:file_no_ext . '&& echo "" && ' . l:file_no_ext . ' && rm ' . l:file_no_ext

    " Check if a terminal is open
    if empty(filter(range(1, bufnr('$')), 'getbufvar(v:val, "&filetype") == "toggleterm"'))
        " Open a terminal if it's not open
        exe 'ToggleTerm'
    else
        " If terminal is open, switch to it
        exe 'wincmd w'
    endif

    " Send the command to the terminal
    call feedkeys("i" . l:cmd . "\<CR>\<c-w>\<c-w>")
endfunction
nnoremap <leader>r :call CompileAndRunCpp()<CR>


" Press gr to refactor variable in scope
function! RefactorVariable()
    normal! gd
    let l:cmd = "::s/" . expand('<cword>') . "//g\<Left>\<Left>"
    normal! [{V%
    call feedkeys(l:cmd, 'n')
endfunction

nnoremap gr :call RefactorVariable()<CR>

set completeopt+=menuone,noselect                                                   " Enable completion

let g:diagnostic_enable_virtual_text = 1                                            " Enable virtual text diagnostics

lua <<EOF
require'toggleterm'.setup{
  size = 60,                                                                        -- The size of the terminal. Only works for vertical and horizontal types
  hide_numbers = true,                                                              -- Hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1,                                                               -- the degree by which to darken the terminal color
  start_in_insert = false,
  insert_mappings = false,                                                          -- default mappings that work in ide work in term or not
  terminal_mappings = true,
  persist_size = true,
  direction = 'vertical',                                                           -- 'vertical' or 'horizontal' | 'float' opens in a floating window
  -- This callback runs when the terminal is first opened
  -- on_open = function(term)
  --   vim.cmd('call ChangeToFileDir()')
  -- end,
}

local lspconfig = require('lspconfig')
lspconfig.clangd.setup{}

require('telescope').setup{
  pickers = {
    find_files = {
      hidden = true
    }
  },
  defaults = {
    file_ignore_patterns = {
      "^(?!.config/|Documents/|code/|Downloads/).*$"
    },
  }
}
EOF
