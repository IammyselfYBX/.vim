" Coc.nvim配置文件
 "每次都会检验是否安装,如果没有安装会自动安装
let  g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-snippets']


"允许未保存文件就可以跳转其他文件，但是退出的时候会提醒
set hidden

"让vim相应更快
set updatetime=100

set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" 这里是<TAB>,但是好像<C-n>也可以实现相识的功能
"
"inoremap <silent><expr> <TAB> 
"      \ pumvisible() ? "\<C-l>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction


" Use <c-o> to trigger completion.
" <C-o>调出补全
inoremap <silent><expr> <c-o> coc#refresh()


" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" 用<CR>选择补全内容
" 回车选中补全，而不是换行
"
" pumvisible() 是 Vimscript 中的一个函数，用于检查弹出菜单（通常是自动补全菜单）是否可见。
"   如果弹出菜单当前可见，pumvisible() 将返回 1，否则返回 0。
"   这个函数通常用于在映射（mapping）中改变基于弹出菜单状态的行为。
"
" feedkeys() 是 Vimscript 中的一个函数，它的作用是将字符串作为键盘输入插入到输入流中。这个函数的常见用途是模拟用户的键盘输入。
"   feedkeys() 函数接受两个参数
"     第一个参数是你想要输入的字符串。这个字符串可以包含普通的字符，也可以包含特殊的键盘按键。例如，"\<C-g>u\<CR>" 就表示 Control + g, u, 然后回车。
"     第二个参数是一个可选的字符串，用来控制 feedkeys() 的行为。例如，"n" 表示将输入的字符作为普通模式的命令来处理。
"
" <C-y> 
"   在插入模式和命令行模式下：会插入上一行的当前列的字符。
"   弹出菜单（如自动补全菜单）可见时：<C-y> 会选择当前高亮的补全项，并关闭弹出菜单。
"
" <C-g>u
"   在 Vim 中，连续的插入操作会被视为一个撤销块，也就是说，如果你在插入模式下连续输入了多个字符，然后切换到普通模式，按 u 键进行撤销操作，会将你在插入模式下输入的所有字符一次性撤销。
"   但是，如果你在插入模式下输入了 <C-g>u，那么 Vim 会在这里打破撤销序列，也就是说，<C-g>u 之后的插入操作会被视为一个新的撤销块。这样，你就可以分别撤销 <C-g>u 之前和之后的插入操作了。
"   例如，如果你在插入模式下输入了 abc<C-g>udef，然后切换到普通模式，按 u 键进行撤销操作，首先会撤销 def，再按一次 u 键，会撤销 abc。
"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<Esc>:call BraceReturn()\<CR>"
" pumvisible()是一个函数，用于检查是否有一个弹出菜单，
" 如果可见(返回值非0)，执行 \<C-y> 这是一个控制字符，用于从自动完成菜单中选择当前高亮的条目。
" 如果没有弹出菜单可见 (pumvisible() 返回0)，则执行 \<Esc>:call BraceReturn()\<CR>。


"这个操作首先发送 Escape 键退出插入模式，然后调用 BraceReturn() 函数，最后按下 Enter 键执行该命令。
function! BraceReturn()
  let b:letters = strcharpart(getline('.')[col('.') - 1:], 0, 2)  " 这行代码获取当前光标位置后的两个字符。
  if b:letters == '{}' " 如果是一行的结尾是{}回车启用自动换行效果
    call feedkeys("li\<CR>\<Esc>ko", "n")
  else
    call feedkeys("i\<CR>", "n")
  endif
endfunction


" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<Esc>:call BraceReturn()\<CR>"
" function! BraceReturn()
"   let b:letters = strcharpart(getline('.')[col('.') - 1:], 0, 2)
"   if b:letters == '{}' " 如果是一行的结尾是{}回车启用自动换行效果
"     call feedkeys("li\<CR>\<Esc>\ko", "n")
"   else
"     "call feedkeys('o')
"     return "\<C-y>"
"   endif
" endfunction
" inoremap <expr> <CR> BraceReturnOrComplete()  

" inoremap <expr> <CR> BraceReturnOrComplete()       
"               
" function! BraceReturnOrComplete()  
"   if pumvisible()  
"     return "\<C-y>"  
"   else  
"     call BraceReturn()  
"     return "\<CR>"  
"   endif  
" endfunction  
" 
" function! BraceReturn()  
"   let b:letters = strcharpart(getline('.')[col('.') - 1:], 0, 2)  
"   if b:letters == '{}' " 如果一行的结尾是{}，则回车启用自动换行效果  
"     call feedkeys("li\<CR>\<Esc>\ko", "n")  
"   else  
"     " 原来的逻辑：如果没有{}，则执行这里的代码  
"     " （这里可以放置您原本打算放在“整合位置”的代码）  
"     " 例如，您可以返回一个普通的回车，或者执行其他操作  
"     " 目前这里什么都不做，只是返回普通的回车  
"   endif  
" endfunction

" 如果vim 支持 `complete_info` 可以用下面的代码
" if exists('*complete_info')
"   inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif




" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" 使用 <LEADER>up 跳转上一个报错代码
" 使用 <LEADER>down 跳转上一个报错代码
nmap <silent> <LEADER><up>  <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER><down> <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
" 使用<C-h> 来查看文档,就是该变量/函数是干什么用的
nnoremap <silent> <C-h> :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" coc-snippets
"" Use <C-l> for trigger snippet expand.
imap <tab> <Plug>(coc-snippets-expand)
"" Use <tab> for select text for visual placeholder of snippet.
vmap <tab> <Plug>(coc-snippets-select)
"" Use <tab> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<tab>'
"" Use <S-tab> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<S-tab>'
"" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
"" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

