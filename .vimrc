"[tony@tony-pc .vim]$ figlet YBX vimrc
"
"__   ________  __        _                      
"\ \ / / __ ) \/ / __   _(_) _ __ __  _ __ ___   
" \ V /|  _ \\  /  \ \ / / | '_ ` _\\| '__/ __|  
"  | | | |_) /  \   \ V /| | | | | | | | | (__   
"  |_| |____/_/\_\   \_/ |_|_| |_| |_|_|  \___|  
"
"
"============================================================
"========== 自定义快捷键 ====================================
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


"=============================================================
"============ 显示设置 =======================================
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
set tabstop=2     " 一个tab相当于2个空格
set shiftwidth=4  " 用于自动缩进的空格数
set et   	" 将tab转成空格
autocmd FileType python setlocal sw=4 ts=4 et ai

"------------------------------------------
"进入写入模式光标变成竖线
"https://blog.csdn.net/xiaxzhou/article/details/78515044
"------------------------------------------
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' |
    \   silent execute '!echo -ne "\e[6 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[4 q"' | redraw! |
    \ endif

  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

"------- 高亮 -------------
syntax on "代码高亮
"==============================
" 主题配置
"------------------------
" 启用真彩色
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
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


"------- 搜索 ----------
set hlsearch "设置搜索高亮
"每次打开新的文件去除上次搜索高亮
exec "nohlsearch" 
noremap <LEADER><CR> :nohlsearch<CR>
set incsearch 	"一边输入一边高亮
set ignorecase 	"忽略大小写搜索
set smartcase 	"智能搜索
" 上一个搜索，下一个搜索 

"------------ 分屏-------------
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

"横变竖，竖变横
noremap sv <C-w>t<C-w>H "横变竖
noremap sh <C-w>t<C-w>K "竖变横

"左右互换，上下互换
noremap sr <C-w>r 

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
set foldmethod=indent "代码折叠
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



"====================================================
"============= 文件格式 =============================
" set encoding=utf-8 " 不处理中文
set fileencodings=ucs-bom,utf-8,gb18030,latin1 "处理中文

"想使用 <SPACE><SPACE> 来进行跳转下一个占位符
"noremap <SPACE><SPACE> <Esc>/<++><CR>:nohlsearch<CR>ciw
noremap <SPACE><SPACE> <Esc>/<++><CR>:nohlsearch<CR>4cl


":%TOhtml 想打印 html 文件


"=================================
"======= 终端=====================
"=================================
" 我一般想让终端在下面
if has('nvim')
  " This is Neovim
  noremap <LEADER>t :split term://bash<CR>:set modifiable<CR>
else
  " This is Vim
  noremap <LEADER>t :set splitbelow<CR>:term<CR>
endif



"====================================
"======== 新建tab ===================
"====================================
noremap <LEADER><TAB> :tabedit<CR>
noremap tn :+tabnext<CR>
noremap tu :-tabnext<CR>


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




"================================================================================================================
"========================================== 插件管理 ============================================================
"================================================================================================================
"----------------------------------------------------------------------------------------------------------------
" 如果像以后一直到其他系统直接下载vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync |  source $MYVIMRC
endif

"----------------------------------------------------------------------------------------------------------------
"----------------------------------------- 插件安装 -------------------------------------------------------------
"----------------------------------------------------------------------------------------------------------------
" 更多插件见 https://vimawesome.com/
call plug#begin('~/.vim/plugged')
  " 获得vim-plug的帮助手册
  Plug 'junegunn/vim-plug' 
  let g:plug_url_format='https://git::@hub.fastgit.org/%s.git' "更换国内github加速镜像
  " let g:plug_url_format = 'git@github.com:%s.git' "设置为ssh协议访问
  
  " airline       ~/.vim/plugin/airline.vim
	Plug 'vim-airline/vim-airline'

	"nertree ~/.vim/plugin/nerdtree/nerdtree.vim
  "nerdtree-git  ~/.vim/plugin/nerdtree/nerdtree-git.vim 
  Plug 'preservim/nerdtree',{'on':  'NERDTreeToggle'} " 表明执行NERDTreeToggle才加载插件
	Plug 'Xuyuanp/nerdtree-git-plugin'

  " vim-gutentags 自动索引 ~/.vim/plugin/vim-gutentags.vim
  "Plug 'ludovicchabant/vim-gutentags'

  "tagbar  ~/.vim/plugin/tagbar.vim
  Plug 'preservim/tagbar'

  " AsyncRun ~/.vim/plugin/asyncrun.vim
  Plug 'skywind3000/asyncrun.vim'

  "ale 代码检验   ~/.vim/plugin/ale.vim
	Plug 'dense-analysis/ale'	

  "coc ~/.vim/plugin/coc.vim
  " $> pacman -S nodejs yarn
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'yelled1/coc-python', {'do': 'yarn install --frozen-lockfile'}

  " fzf ~/.vim/plugin/fzf.vim
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  "vim snippets ~/.vim/plugin/snippet.vim
  "Plug 'SirVer/ultisnips'   "snippets引擎 已经用coc-snippets取代
  " coc的snippets具体配置文件 ~/.vim/c-settings.json
  " 其中 YBXUltiSnips 是自定义的snippets
  " vim-snippets/UltiSnips是现成的snippets
	Plug 'honza/vim-snippets' "代码小片段
  let g:python3_host_prog = "/usr/bin/python3"

  """ markdown 
  " Markdown Preview for (Neo)vim ~/.vim/plugin/markdown/markdown-preview-for-vim.vim 
  " 需要预览数学公式需要安装iamcco/mathjax-support-for-mkdp
	Plug 'iamcco/mathjax-support-for-mkdp', { 'for': 'markdown' } 
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown'}	 
	"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}	 
  " 加上 'for': ['markdown', 'vim-plug']} 就是只有加载markdown的时候,才加载这个插件,这样启动会快一些
  " vim-table-mode
  Plug 'dhruvasagar/vim-table-mode'

	" A Vim Plugin for Lively Previewing LaTeX PDF Output
  " ~/.vim/plugin/latex/vim-latex-live-preview.vim
	Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }	" 用pdf软件实时预览latex文档的编写
  
  " Undo-tree     ~/.vim/plugin/undotree.vim
  Plug 'mbbill/undotree'
  
  "github copilot ~/.vim/plugin/github-copilot.vim
  Plug 'github/copilot.vim'
call plug#end()

"=============================================
"  配置Ctags
" set tags=tags;  " 从父目录递归查找tags文件
"noremap <C-[> <C-t>
" 保存python文件时，自动重新生成标签文件
" autocmd BufWritePost *.py silent! !ctags -R &
" autocmd BufWritePost *.c *.h silent! !ctags -R &
" autocmd BufWritePost *.cpp *.h silent! !ctags -R &
"=============================================
"set tags=./.tags;,.tags 
" 前半部分 “./.tags; ”代表在文件的所在目录下（不是 “:pwd”返回的 Vim 当前目录）查找名字为 “.tags”的符号文件，后面一个分号代表查找不到的话向上递归到父目录，直到找到 .tags 文件或者递归到了根目录还没找到，这样对于复杂工程很友好，源代码都是分布在不同子目录中，而只需要在项目顶层目录放一个 .tags文件即可；逗号分隔的后半部分 .tags 是指同时在 Vim 的当前目录（“:pwd”命令返回的目录，可以用 :cd ..命令改变）下面查找 .tags 文件。
"set autochdir           " set autochdir为自动切换当前目录为当前文件所在的目录


" 可以按 gf 跳转到该文件





"=================vim-table-mode----------
" 使用说明
" <C-\> 开启/关闭
" 1. '[|', ']|', '{|' '}|' 分别表示移动向 left | right | up | down 
" 2. i| 表示向前插入一个格
"    a| 表示向后插入一个格
" 3.<Leader>tdd 删除当前行
" 4.<Leader>tdc 删除当前列
" 4.<Leader>tic 前面插入一列

"-----------------------------------------------------------------------------
" Vim的autocmd FileType 判断语言类型，<C-c>来进行编译 <C-i>运行
"-----------------------------------------------------------------------------
        " C Compiler:
        "autocmd FileType c nnoremap <buffer> <C-c> :!gcc % -o %< && ./%< <CR>
        autocmd FileType c nnoremap <buffer> <C-c> :AsyncRun gcc -Wall % -o %< <CR>
        "autocmd FileType c nnoremap <buffer> <C-r> :! ./%< <CR>
        autocmd FileType c nnoremap <buffer> <C-r> :AsyncRun ./%< <CR>

        " C++ Compiler
        au BufRead,BufNewFile *.h set filetype=cpp "有时.h文件默认时C的,引入C++的头文件ALE会报错
        "autocmd FileType cpp nnoremap <buffer> <C-i> :!g++ % -o %< && ./%:r <CR>
        autocmd FileType cpp nnoremap <buffer> <C-c> :AsyncRun g++ % -o %< <CR>
        autocmd FileType cpp nnoremap <buffer> <C-r> :AsyncRun ./%:r <CR>

        " Python Interpreter
        " autocmd FileType python nnoremap <buffer> <C-i> :!python % <CR>
        autocmd FileType python nnoremap <buffer> <C-r> :AsyncRun python3 % <CR>

        " Bash script
        " autocmd FileType sh nnoremap <buffer> <C-i> :!sh % <CR>
        autocmd FileType python nnoremap <buffer> <C-r> :AsyncRun sh % <CR>

        " Executable
        " nnoremap <buffer> <C-i> :!./% <CR>
        nnoremap <buffer> <C-r> :AsyncRun ./% <CR>

        " RCs (Configs)
        autocmd FileType vim,zsh,tmux nnoremap <buffer> <C-r> :source % <CR>

				" Java
				"autocmd Filetype java nnoremap <buffer> <C-i> :!javac % && java %:r <CR>
				autocmd Filetype java nnoremap <buffer> <C-c> :AsyncRun javac % <CR>
				"autocmd Filetype java nnoremap <buffer> <C-i> :! java %:r <CR>
        autocmd Filetype java nnoremap <buffer> <C-r> :AsyncRun java %:r <CR>

        " HTML
        autocmd Filetype html nnoremap <buffer> <C-i> :!firefox % &<CR>

        " Markdown 前提是已经安装MarkdownPreview插件
        autocmd Filetype markdown nnoremap <buffer> <C-r> :MarkdownPreview <CR>
        autocmd Filetype markdown source ~/.vim/UltiSnips/markdown.vim

        " Latex 
        autocmd Filetype tex nnoremap <buffer> <C-c> :AsyncRun latexmk <cr>
        autocmd Filetype tex nnoremap <buffer> <C-r> :LLPStartPreview<cr>


"---------------------------------------------------
" gdb调试
"---------------------------------------------------
" <F8> 调试c/c++
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    if &filetype == 'c'
            exec "!gcc % -g -o %<"
            exec "!gdb -q ./%<"
    elseif &filetype == 'cpp'
            exec "!g++ % -g -o %<"
            exec "!gdb -q ./%<"
    elseif &filetype =='sh'
            exec "!bash -x %"
    endif
endfunc












