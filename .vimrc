set number
set relativenumber
set tabstop=3
set shiftwidth=3
set expandtab

"Keep the cursor in the middle while scrolling
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap n nzz
nnoremap N Nzz

"Paste over a visually selected area without the selection being placed in the default register
xnoremap P Pgvy
