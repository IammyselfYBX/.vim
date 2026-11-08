" 外观设置
set wildmenu                      " 启用增强的Tab自动补全
"set wildmode=list:longest,full   " 全屏显示所有自动补全的选项

set scrolloff=5                   " 永远与最上面，最下面保持5行
set cursorline                    " 显示一条线
set showcmd                       " 输入的命令显示出来，看的清楚些
set backspace=indent,eol,start	  " backspace在行首去到上一行行尾
set autochdir		                  " 自动切换当前目录为当前文件所在的目录

"---------------------------------------------
"自动换行
set wrap                          " 一行太长了自动换行
set linebreak                     " 折行不拆分单词

"-----------------------------------
" 当终端足够宽的时候，显示行号
" if &co >80
"     set number
" "    set relativenumber
" endif

"------------------------------------------
" 配置vim，按tab键缩进2个空格，如果是python文件，缩进4个空格
"------------------------------------------
set autoindent   	" 开始新的一行自动缩进
set expandtab     " 将制表符Tab展开成空格
set tabstop=2       " 一个tab相当于2个空格
set shiftwidth=2    " 自动缩进使用2个空格
set softtabstop=2   " 编辑时按Tab也按2个空格处理
set expandtab       " 将tab转成空格
augroup TonyPythonIndent
  autocmd!
  autocmd FileType python setlocal sw=2 ts=2 sts=2 et ai
augroup END

"------------------------------------------
"进入写入模式光标变成竖线
"https://blog.csdn.net/xiaxzhou/article/details/78515044
"------------------------------------------
if has("autocmd")
  augroup TonyCursorShape
    autocmd!
    au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
    au InsertEnter,InsertChange *
      \ if v:insertmode == 'i' |
      \   silent execute '!echo -ne "\e[6 q"' | redraw! |
      \ elseif v:insertmode == 'r' |
      \   silent execute '!echo -ne "\e[4 q"' | redraw! |
      \ endif
    au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
  augroup END
endif

"------- 高亮 -------------
syntax on "代码高亮
"==============================
" 主题配置
"------------------------
" 启用真彩色（Vim 和 Neovim 都支持）
if (has("termguicolors"))
  set termguicolors
endif

" gruvbox
"try
"    colorscheme gruvbox
"    set background=dark
"catch
"    echo "访问 https://github.com/morhetz/gruvbox下载"
"endtry

"------------------------
" palenight配置
try
    colorscheme palenight
    let g:palenight_terminal_italics=1 " 默认字体是斜体
    set background=dark
catch
    echo "访问https://github.com/drewtempelmeyer/palenight.vim下载"
endtry
