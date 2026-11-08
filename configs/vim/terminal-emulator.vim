" 终端模拟器
" 我一般想让终端在下面
if has('nvim')
  noremap <LEADER>t :split term://bash<CR>
  set mouse=
else
  noremap <LEADER>t :set splitbelow<CR>:term<CR>
endif

" 执行ESC退出终端
tnoremap <Esc> <C-\><C-N>
tnoremap <C-V><Esc> <Esc>
