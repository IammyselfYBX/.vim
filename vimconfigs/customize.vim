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
" 定义跳过功能
function! JumpOver(char)
    if getline(".")[col(".")-1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

" 定义插入配对符号的功能
function! InsertPair(open, close)
    " 获取光标位置后的字符
    let next_char = getline(".")[col(".") - 1]

    " 判断光标后面的字符是否为空白符号
		if next_char =~ '\s' || next_char == '' || next_char == a:close
        return a:open . a:close . "\<Left>"
    else
        return a:open
    endif
endfunction

" 在insert模式下自动跳过配对符号
inoremap <expr> ) JumpOver(')')
inoremap <expr> ] JumpOver(']')
inoremap <expr> } JumpOver('}')
inoremap <expr> > JumpOver('>')

" 插入配对符号的映射
inoremap <expr> ( InsertPair('(', ')')
inoremap <expr> [ InsertPair('[', ']')
inoremap <expr> { InsertPair('{', '}')
inoremap <expr> ' InsertPair("'", "'")
inoremap <expr> " InsertPair('"', '"')

" 删除配对符号的功能
function! DeletePair(open, close)
    let line = getline(".")
    let col = col(".")
    " 判断当前字符是否为配对符号之一
    if col > 1 && col <= len(line) && line[col - 2] == a:open && line[col - 1] == a:close
        return "\<BS>\<Del>"
    else
        return "\<BS>"
    endif
endfunction

" 在insert模式下删除前一个符号时自动删除后一个符号
inoremap <expr> <BS> DeletePair('(', ')')
inoremap <expr> <BS> DeletePair('[', ']')
inoremap <expr> <BS> DeletePair('{', '}')
inoremap <expr> <BS> DeletePair("'", "'")
inoremap <expr> <BS> DeletePair('"', '"')

" 根据文件类型设置不同的映射
augroup FileTypeSettings
    autocmd!
    autocmd FileType html inoremap <expr> < InsertPair('<', '>')
    autocmd FileType * if &filetype != 'html' | inoremap < < | endif
augroup END



"======== 新建tab ===================
noremap <LEADER><TAB> :tabedit<CR>
noremap tn :+tabnext<CR>
noremap tu :-tabnext<CR>

