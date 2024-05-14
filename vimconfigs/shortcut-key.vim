" 自定义快捷键
"<S-q> 多行的Command-Line模式。
" 调换两个键的功能
"noremap <C-q> Q   
"nnoremap Q :q<CR>:q
"noremap s <nop>	
"小写s是删除当前字符，将s变成 no operation

" <C-q> 是退出
nnoremap <C-q> :q<CR>

" <C-r> 是刷新配置文件
noremap <C-S-r> :source $MYVIMRC<CR>

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
" <C-a> 全选
inoremap <C-a> <ESC>ggVG
noremap <C-a> <ESC>ggVG

" --当前数字-1
" ==当前数字+1(因为+还需要按Shift，就改成==)
noremap -- <C-x>
noremap == <C-a>

" 设置Leader键为 空格
let mapleader = "\<space>"
"let mapleader = " "