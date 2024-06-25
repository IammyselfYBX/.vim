" 文件设置
"====================================================
"============= 文件格式 =============================
" set encoding=utf-8 " 不处理中文
set fileencodings=ucs-bom,utf-8,gb18030,latin1 "处理中文
" ga 查看字符编码
" g8 查看文件编码
" gf 打开文件

"想使用 <SPACE><SPACE> 来进行跳转下一个占位符
"noremap <SPACE><SPACE> <Esc>/<++><CR>:nohlsearch<CR>ciw
noremap <SPACE><SPACE> <Esc>/<++><CR>:nohlsearch<CR>4cl


":%TOhtml 想打印 html 文件


"===================================
"====== SWAP file ==================
"===================================
" 设置Swap文件位置
" 如果
if !filewritable(expand('~/.vim/swap'))    " 判断文件是否存在"
    silent exec "!mkdir -p ~/.vim/swap"
endif
" set directory=$HOME/.vim/swap//
if has('nvim')
  " This is Neovim
  set dir=$HOME/.vim/swap//
else
  " This is Vim
  set directory=$HOME/.vim/swap//
endif


"==============================
"撤销与备份
"==============================
set nobackup
set undofile  "重新打开文件依旧可以撤销之前的编辑
set undodir=$HOME/.vim/undodir
" 使用vim自动创建
if !isdirectory(&undodir)
  call mkdir(&undodir, 'p', 0700)
endif

" iabbrev YBX_demo YBX is the most handsome man in NCEPU

"============================
"filetype
"==========================
filetype on
filetype indent on
filetype plugin on

"============================
" 文件类别定义
"===========================
au BufRead,BufNewFile *.cu,*.cuh set filetype=cuda

