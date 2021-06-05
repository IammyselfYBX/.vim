" https://github.com/skywind3000/asyncrun.vim/blob/master/README-cn.md
" https://zhuanlan.zhihu.com/p/106788219
" 自动打开 quickfix window ，高度为 6
  let g:asyncrun_open = 6
" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<CR>
nnoremap ! :AsyncRun 

" 从文件所在目录向上递归，直到找到名为 “.git”, “.svn”, “.hg”或者 “.root”文件或者目录，如果递归到根目录还没找到，那么文件所在目录就被当作项目目录，你重新定义项目标志
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']
