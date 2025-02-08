" Use <Space> as the leader key
let mapleader = " "  " Set the leader key to space

" Exit insert mode with 'jj'
inoremap jj <ESC>

" Add new lines without entering insert mode
nnoremap <leader>o o<ESC>
nnoremap <leader>O O<ESC>

" Remap macro to tilde
nnoremap ` @

" Marker remap
nnoremap m `
nnoremap M m

" Paste from yank/copy register
nnoremap <leader>p "0p
nnoremap <leader>P "0P