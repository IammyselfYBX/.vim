" 在插入模式 <C-\> 开启 vim-table-mode 开关
imap <C-\> <ESC>:TableModeToggle<CR>i


" --------------------------------------------------------------
" 表格外观配置
" --------------------------------------------------------------
" 表格角落字符
let g:table_mode_corner='|'
" 表格分隔符
let g:table_mode_delimiter=' '
" 表格边框字符
let g:table_mode_separator='|'
" 表格填充字符
let g:table_mode_fillchar='-'

" 表头样式配置
let g:table_mode_corner_corner='|'
let g:table_mode_header_fillchar='-'
let g:table_mode_align_char=':'
""" 设置表格角落字符为竖线 |"
""let g:table_mode_corner='|'
""" 置表格分隔符为空格
""let g:table_mode_delimiter=' '
""
""" 设置表头格式
""" let g:table_mode_corner_corner='+'
""" let g:table_mode_header_fillchar='='

" -------------------------------------------------------
" 表格实时功能
" -------------------------------------------------------
" 启用表格实时对齐（推荐开启）
" let g:table_mode_always_active = 1
" 启用表格语法高亮
let g:table_mode_syntax = 1
" 启用表格自动格式化
let g:table_mode_auto_align = 1

""" ------------------------------------------------------
""" 表格创建快捷键
""" ------------------------------------------------------
""" 快速创建表格模板（普通模式）
""nnoremap <Leader>tt :TableModeRealign<CR>
""" 创建 Markdown 风格表格
""nnoremap <Leader>tm :call tablemode#TableizeByDelimiter('\|')<CR>
""" 创建 CSV 风格表格
""nnoremap <Leader>tc :call tablemode#TableizeByDelimiter(',')<CR>
""
""" ----------------------------------------------------
""" 表格编辑快捷键
""" ---------------------------------------------------
""" 表格行操作
""nnoremap <Leader>tdd :call tablemode#table#DeleteRow()<CR>
""nnoremap <Leader>tic :call tablemode#table#DeleteColumn()<CR>
""nnoremap <Leader>tiC :call tablemode#table#AddColumn(1)<CR>
""nnoremap <Leader>tir :call tablemode#table#AddRow(1)<CR>
""
""" 表格单元格移动（插入模式）
""inoremap <Tab> <C-R>=tablemode#table#MoveToNextCell()<CR>
""inoremap <S-Tab> <C-R>=tablemode#table#MoveToPreviousCell()<CR>
""
""" 表格排序功能
""vnoremap <Leader>ts :call tablemode#table#Sort('')<CR>
""
""" -----------------------------------------------------------------------------
""" 表格格式化快捷键
""" -----------------------------------------------------------------------------
""" 重新对齐当前表格
""nnoremap <Leader>tr :TableModeRealign<CR>
""" 格式化选中的文本为表格
""vnoremap <Leader>tf :Tableize<CR>
""" 转换 CSV 到表格
""vnoremap <Leader>T :Tableize/,<CR>
""
""" -----------------------------------------------------------------------------
""" 表头操作快捷键
""" -----------------------------------------------------------------------------
""" 添加表头分隔线
""nnoremap <Leader>thr :call tablemode#table#AddHeaderLine()<CR>
""" 删除表头分隔线
""nnoremap <Leader>thd :call tablemode#table#DeleteHeaderLine()<CR>

" -----------------------------------------------------------------------------
" 表格导出功能
" -----------------------------------------------------------------------------
" 转换表格为 HTML
command! TableToHTML :call tablemode#table#ToHTML()
" 转换表格为 LaTeX
command! TableToLaTeX :call tablemode#table#ToLaTeX()

" -----------------------------------------------------------------------------
" 文件类型特定配置
" -----------------------------------------------------------------------------
" Markdown 文件中的特殊配置
"autocmd FileType markdown let g:table_mode_corner_corner='+'
"autocmd FileType markdown let g:table_mode_header_fillchar='='
"
"" reStructuredText 文件配置
"autocmd FileType rst let g:table_mode_corner='+'
"autocmd FileType rst let g:table_mode_separator='+'
"autocmd FileType rst let g:table_mode_fillchar='='



