" 终端模拟器
" 我一般想让终端在下面
if has('nvim')
  " This is Neovim
  noremap <LEADER>t :split term://bash<CR>:set modifiable<CR>
else
  " This is Vim
  noremap <LEADER>t :set splitbelow<CR>:term<CR>
endif

" 执行ESC退出终端
tnoremap <Esc> <C-\><C-N>
tnoremap <C-V><Esc> <Esc>

"禁用鼠标
if has('nvim')
    " 禁用鼠标
    set mouse=
    "set mouse=n "启用鼠标普通模式
endif