" 在插入模式 <C-\> 开启 vim-table-mode 开关
imap <C-\> <ESC>:TableModeToggle<CR>i
" || 展开|-----------|------------|


" Use this option to define the table corner character
let g:table_mode_corner='|'
" Use this option to define the delimiter which used by
let g:table_mode_delimiter=' '

" 设置表头格式
" let g:table_mode_corner_corner='+'
" let g:table_mode_header_fillchar='='

