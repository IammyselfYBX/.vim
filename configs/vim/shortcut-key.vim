" 自定义快捷键
"<S-q> 多行的Command-Line模式。
" 调换两个键的功能
"noremap <C-q> Q   
"nnoremap Q :q<CR>:q
"noremap s <nop>	
"小写s是删除当前字符，将s变成 no operation

" <C-q> 是退出
nnoremap <C-q> :q<CR>

" 刷新配置
nnoremap <Leader>r :source $MYVIMRC<CR>

" <S-u> 是恢复撤销的内容
" <C-u> 来撤消对整行的修改。
noremap <S-u> <C-r>
noremap <C-u> <S-u>



" 交换 $ 与 g_ 的快捷键
" 0：跳转行首
" $：跳转行尾
" ^：跳转非空格行首
" g_：跳转非空格行尾
noremap $ g_
noremap g_ $


" <C-s> 保存
noremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>a
vnoremap <C-x> d
cnoremap w!! w !sudo tee %

" <TAB> 键
" 可见 ~/.vim/plugin/coc.vim 
" 重新定义在i模式下的<TAB>多重行为

" <CR> 键
" 可见 ~/.vim/plugin/coc.vim 
" 重新定义在i模式下的<CR>多重行为


" <C-d> 剪切当前行
inoremap <C-d> <ESC>ddi
" <C-w> ∨im默认删除上一个单词
" <C-p> 是粘帖剪切的行
"inoremap <C-p> <ESC>pi
" set pastetoggle=<F3> "按<F3>进入粘帖模式,在按<F3>退出粘帖模式
" <C-a> 不覆盖，恢复 Vim 原生行为
" Normal 模式: 增加光标下数字
" Insert 模式: 插入上一次插入的文本

" --当前数字-1
" ==当前数字+1(因为+还需要按Shift，就改成==)
noremap -- <C-x>
noremap == <C-a>

" 按当前缩进规则重新缩进整个文件
nnoremap <Leader>= gg=G

" 设置Leader键为 空格
let mapleader = "\<space>"
"let mapleader = " "
