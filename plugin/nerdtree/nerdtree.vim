"------------------ NERDTree插件配置 -------------------------
" 可以参看 https://github.com/preservim/nerdtree
"将F2设置为开关NERDTree的快捷键
nnoremap <silent> <f2> :NERDTreeToggle<CR>

" 不想看见 NerdTree 的提示
let NERDTreeMinimalUI = 1

"修改树的显示图标
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" let g:NERDTreeDirArrowExpandable = '+'
" let g:NERDTreeDirArrowCollapsible = '-'

"窗口位置
  let g:NERDTreeWinPos='left'

"窗口尺寸
  let g:NERDTreeSize=30

"不显示隐藏文件
  let g:NERDTreeHidden=0

" 启动时显示书签
"let NERDTreeShowBookmarks=1

"Vim启动时自动打开NERDTree
" autocmd VimEnter * NERDTree 

" 关闭视窗的时候 NerdTree 也同时关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
