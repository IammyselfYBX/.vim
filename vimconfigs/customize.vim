" 个性化设置
" 判断操作系统
let g:is_mac = has('macunix')
let g:is_linux = has('unix') && !has('macunix')
let g:is_windows = has('win32') || has('win64')

"------- 搜索 ----------
set hlsearch "设置搜索高亮
"每次打开新的文件去除上次搜索高亮
exec "nohlsearch" 
noremap <LEADER><CR> :nohlsearch<CR>
set incsearch 	"一边输入一边高亮
set ignorecase 	"忽略大小写搜索
set smartcase 	"智能搜索
" 上一个搜索，下一个搜索 

"---------------------------------------
"vim 打开文件位置为上次关闭光标的位置
"---------------------------------------
if has("autocmd")
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"----------------------------------------
" 代码折叠
"----------------------------------------
" vim 提供 6中折叠方式
"     manual           手工定义折叠
"     indent           更多的缩进表示更高级别的折叠
"     expr             用表达式来定义折叠
"     syntax           用语法高亮来定义折叠
"     diff             对没有更改的文本进行折叠
"     marker           对文中的标志折叠
"
"
"set fdm=indent
"set foldmethod=indent "代码折叠
autocmd BufRead * normal zR " 默认打开新文件折叠全部打开
" zc  折叠
" zC  对所在范围内所有嵌套的折叠点进行折叠
" zo  展开折叠
" zO  对所在范围内所有嵌套的折叠点展开
" zR  打开所有的折叠
" zM  关闭所有的折叠


"----------------------------------------------------
" 符号匹配
"----------------------------------------------------
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap < <><Esc>i
inoremap { {}<Esc>i
" inoremap ' ''<Esc>i
" inoremap " ""<Esc>i
" 实现当重复输入的时候自动跳过
function! JumpOver(char)
    if getline(".")[col(".")-1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction
inoremap <expr> ) JumpOver(')')
inoremap <expr> ] JumpOver(']')
inoremap <expr> > JumpOver('>')
inoremap <expr> } JumpOver('}')
"inoremap <expr> ' JumpOver('\'')
"inoremap <expr> " JumpOver('"')


"======== 新建tab ===================
noremap <LEADER><TAB> :tabedit<CR>
noremap tn :+tabnext<CR>
noremap tu :-tabnext<CR>

