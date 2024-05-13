" 分屏相关
" 希望所有新的分屏都会直接出现在下面,和右边
set splitbelow 
set splitright 
"左右分屏 光标在右边
noremap s<right> :set splitright<CR>:vsplit<CR>
inoremap <S-right> <ESC>:set splitright<CR>:vsplit<CR>i
"左右分屏 光标在左边
noremap s<left> :set nosplitright<CR>:vsplit<CR>
inoremap <S-left> <ESC>:set nosplitright<CR>:vsplit<CR>i
"上下分屏 光标在上边
noremap s<up> :set nosplitbelow<CR>:split<CR>
inoremap <S-up> <ESC>:set nosplitbelow<CR>:split<CR>i
"上下分屏 光标在下边
noremap s<down> :set splitbelow<CR>:split<CR>
inoremap <S-down> <ESC>:set splitbelow<CR>:split<CR>i


"重新调整左右大小
noremap <C-M-left> :vertical resize-5<CR>
noremap <C-M-right> :vertical resize+5<CR>
noremap <C-M-up> :res +5 <CR>
noremap <C-M-down> :res -5 <CR> 

"分屏移动光标
noremap <C-h> <C-w>h "跳转到左边的窗口
noremap <C-j> <C-w>j "跳转到下边的窗口
noremap <C-k> <C-w>k "跳转到上边的窗口
noremap <C-l> <C-w>l "跳转到右边的窗口
noremap <C-up> <C-w>t "跳转到最顶上的窗口
noremap <C-down> <C-w>b "跳转到最底下的窗口
nnoremap <C-w>0 :only<CR>
"<C-w>= "两个窗口宽度相等

"横变竖，竖变横
noremap sv <C-w>t<C-w>H "横变竖
noremap sh <C-w>t<C-w>K "竖变横

"左右互换，上下互换
noremap sr <C-w>r 