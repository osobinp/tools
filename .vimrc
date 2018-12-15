set et ts=2 ai sw=2 nu
syntax on
:colorscheme desert
set cursorline
autocmd FileType yaml setlocal et ts=2 ai sw=2 nu sts=0

let g:netrw_liststyle = 3
let g:netrw_winsize = 25
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_banner = 0
:set paste
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END
