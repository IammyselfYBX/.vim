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
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
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

