" note: this is an autogenerated file

" MAPPINGS (origin: nvim/lua/fmajor/remap.lua)

let g:mapleader = " "
let g:maplocalleader = "\\"


" moving the visually selected area 
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" append the next line without moving the cursor
nnoremap J mzJ`z
" keep the cursor in the middle of the screen
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" paste without overwriting the register
xnoremap <leader>p "_dP
" yank to the system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" delete to the void register
nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>x "_x
vnoremap <leader>x "_x
nnoremap <leader>D "_D
vnoremap <leader>D "_D

" enclose the selected area and keep inner text selected (like in Intellij)
xnoremap <leader>( <Esc>`<i(<Esc>`>la)<Esc>hv`<l
xnoremap <leader>< <Esc>`<i<<Esc>`>la><Esc>hv`<l
xnoremap <leader>{ <Esc>`<i{<Esc>`>la}<Esc>hv`<l
xnoremap <leader>[ <Esc>`<i[<Esc>`>la]<Esc>hv`<l
xnoremap <leader>" <Esc>`<i"<Esc>`>la"<Esc>hv`<l
xnoremap <leader>' <Esc>`<i'<Esc>`>la'<Esc>hv`<l
xnoremap <leader>` <Esc>`<i`<Esc>`>la`<Esc>hv`<l

" remove Q
nnoremap Q <nop>

" horizontal scroll and centering
nnoremap <C-l> 40lzszH
nnoremap <C-h> 40hzszH
nnoremap zZ zszH



" SETS (origin: nvim/lua/fmajor/set.lua)
" Fat cursor
set guicursor=""

" numbers and relative numbers
set nu
set relativenumber

" 4 space tab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" indenting
set smartindent

" no line wrapping
set nowrap

" don't make backups or swapfiles
set noswapfile
set nobackup
" save history to an undofile
set undodir=os.getenv("HOME") .. "/.vim/undodir"
set undofile

" configure incremental search
set nohlsearch
set incsearch



" keep 8 lines of margin when scrolling
set scrolloff=8
set signcolumn="yes"


set updatetime=50

set colorcolumn="80"


