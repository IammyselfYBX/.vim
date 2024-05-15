
"======================================
"     C  
"======================================
let g:c_gnu = 1
"=============================================
"  配置Ctags
" set tags=tags;  " 从父目录递归查找tags文件
"noremap <C-[> <C-t>
" 保存python文件时，自动重新生成标签文件
" autocmd BufWritePost *.py silent! !ctags -R &
" autocmd BufWritePost *.c *.h silent! !ctags -R &
" autocmd BufWritePost *.cpp *.h silent! !ctags -R &
"=============================================
"set tags=./.tags;,.tags 
" 前半部分 “./.tags; ”代表在文件的所在目录下（不是 “:pwd”返回的 Vim 当前目录）查找名字为 “.tags”的符号文件，后面一个分号代表查找不到的话向上递归到父目录，直到找到 .tags 文件或者递归到了根目录还没找到，这样对于复杂工程很友好，源代码都是分布在不同子目录中，而只需要在项目顶层目录放一个 .tags文件即可；逗号分隔的后半部分 .tags 是指同时在 Vim 的当前目录（“:pwd”命令返回的目录，可以用 :cd ..命令改变）下面查找 .tags 文件。
"set autochdir           " set autochdir为自动切换当前目录为当前文件所在的目录

" 每次存盘自动生成tags文件
" (以弃用) 时延太长
" function! RunCtagsForC(root_path)
"     " 保存当前目录
"     let saved_path = getcwd()
"     " 进入到项目根目录
"     exe 'lcd ' . a:root_path
"     " 执行 ctags；silent 会抑制执行完的确认提示
"     silent !ctags --languages=c --langmap=c:.c.h --fields=+S -R .
"     " 恢复原先目录
"     exe 'lcd ' . saved_path
" endfunction
" " 当 /project/path/ 下文件改动时，更新 tags
" au BufWritePost /project/path/* call
"             \ RunCtagsForC('/project/path/')



