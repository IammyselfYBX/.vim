" 用于管理插件
" 如果以后一直到其他系统直接下载vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync |  source $MYVIMRC
endif


" 更多插件见 https://vimawesome.com/
call plug#begin('~/.vim/plugged')
  " 获得vim-plug的帮助手册
  "======================================
  "    vim-plug
  "======================================
  Plug 'junegunn/vim-plug' 
  " let g:plug_url_format='https://git::@hub.fastgit.org/%s.git' "更换国内github加速镜像
  " let g:plug_url_format = 'git@github.com:%s.git' "设置为ssh协议访问
  "======================================
  " 1.配置文件: ~/.vim/autoload/plug.vim
  "======================================
    
    
  "======================================
  "     airline  
  "======================================
	Plug 'vim-airline/vim-airline'
  "======================================
  " 1.配置文件: ~/.vim/plugin/airline.vim
  "======================================

  "======================================
  "      nertree
  "======================================
	"nertree ~/.vim/plugin/nerdtree/nerdtree.vim
  "nerdtree-git  ~/.vim/plugin/nerdtree/nerdtree-git.vim 
  Plug 'https://github.com/preservim/nerdtree',{'on':  'NERDTreeToggle'} " 表明执行NERDTreeToggle才加载插件
	Plug 'Xuyuanp/nerdtree-git-plugin'
  "======================================
  " 1.配置文件: ~/.vim/plugin/nerdtree/nerdtree.vim
  "             ~/.vim/plugin/nerdtree/nerdtree-git.vim
  "======================================

  "======================================
  " vim-gutentags 自动索引 ~/.vim/plugin/vim-gutentags.vim
  "======================================
  "Plug 'ludovicchabant/vim-gutentags'
  "======================================

  "======================================
  "       tagbar  
  "======================================
  Plug 'preservim/tagbar'
  "======================================
  " tagbar 是一个可以显示当前文件的函数、变量、类等等的一个插件
  " 1.配置文件: ~/.vim/plugin/tagbar.vim
  "======================================
  " <F9> 打开/关闭tagbar

  "======================================
  "       AsyncRun 
  "======================================
  Plug 'skywind3000/asyncrun.vim'
  "======================================
  " 1.配置文件: ~/.vim/plugin/asyncrun.vim
  "======================================
  " <F10>     打开/关闭Quickfix窗口

  "======================================
  "       ale 代码检验   
  "======================================
	Plug 'dense-analysis/ale'	
  "======================================
  " 1.配置文件: ~/.vim/plugin/ale.vim
  "======================================

  "======================================
  "    COC.nvim
  "======================================
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'yelled1/coc-python', {'do': 'yarn install --frozen-lockfile', 'for': 'python'}
  "======================================
  " 1.配置文件: ~/.vim/plugin/coc.vim     在 Vim 中整体集成和使用 coc.nvim
  "             ~/.vim/coc-settings.json  coc.nvim 本身的配置文件
  " 2.安装依赖
  "   pacman -S nodejs yarn
  "======================================
  " <C-o>          调出补全信息
  " <LEADER>up   跳转到上一个报错代码
  " <LEADER>down 跳转到下一个报错代码
  " gd           跳转到变量或函数定义(definition)的位置
  " gy           跳转到类型或实例定义(type-definition)的位置
  " gi           跳转到接口(implementation)的所有实现
  " gr           跳转到引用(references)常量或函数的位置
  " <C-h>        显示帮助文档，该变量/函数是干什么用的
  " <TAB>        跳转到下一个代码补齐位置
  " <S-TAB>      跳转到上一个代码补齐位置
  " <C-j>        展开代码片段也可以跳转到下一个占位符

  "======================================
  " fzf ~/.vim/plugin/fzf.vim
  "======================================
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  "======================================
  " 1.配置文件: ~/.vim/plugin/fzf.vim
  " <C-f>       打开fzf文件搜索
  " <C-b>       打开fzf缓冲区搜索
  " <LEADER>h   打开History 历史记录
  " :Windows    打开窗口列表
  " :Maps       打开键位映射列表
  " :History    打开历史记录
  " :History:   打开命令历史记录
  " :History/   打开搜索历史记录
  " :Snippets   打开代码片段列表
  " :Helptags   打开帮助文档列表
  " :Colors     打开颜色主题列表
  " :GFiles     git ls-files 显示在 Git 仓库中被跟踪的文件列表
  " :GFiles?    git status 显示 Git 仓库中的当前状态
  " Ag          打开Ag搜索 二选其一
  " Rg          打开Rg搜索


  "======================================
  "     vim snippets 
  "======================================
  "Plug 'SirVer/ultisnips'   "snippets引擎 已经用coc-snippets取代
	"Plug 'honza/vim-snippets' "代码小片段
  "======================================
  " 1.配置文件: ~/.vim/plugin/snippet.vim
  " 2.个性化设置
  "let g:python3_host_prog = "/usr/bin/python3"
  " coc的snippets具体配置文件 ~/.vim/c-settings.json
  " 其中 YBXUltiSnips 是自定义的snippets
  " vim-snippets/UltiSnips是现成的snippets
  "======================================
  " 用 coc.nvim 代替了 


  " markdown 
  "" Markdown Preview for (Neo)vim ~/.vim/plugin/markdown/markdown-preview-for-vim.vim 
  "" 需要预览数学公式需要安装 iamcco/mathjax-support-for-mkdp
	""""""Plug 'iamcco/mathjax-support-for-mkdp', { 'for': 'markdown' } 
  "Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown'}	 
  """"""Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
	"" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}	 
  "" 加上 'for': ['markdown', 'vim-plug']} 就是只有加载markdown的时候,才加载这个插件,这样启动会快一些
  "" 使用事项：
  ""       1.到 ~/.vim/plugin/markdown/markdown-preview-for-vim.vim
  ""         修改 mkdp_browser 参数为系统默认的浏览器(默认chromium)
  ""          sudo apt install chromium-browser
  
  """"""Plug 'dhruvasagar/vim-table-mode', { 'do': { -> mkdp#util#install() }, 'for': 'markdown'}
    "======================================
    "     vim-table-mode
    "======================================
    " 1.配置文件 ~/.vim/plugin/markdown/vim-table-mode.vim
    " 
    "======================================
    " <C-\>   开启/关闭 vim-table-mode
    " 1h'[|', ']|', '{|' '}|' 分别表示移动向 left | right | up | down 
    " 2. i| 表示向前插入一个格
    "    a| 表示向后插入一个格
    " 3.<Leader>tdd 删除当前行
    " 4.<Leader>tdc 删除当前列
    " 4.<Leader>tic 前面插入一列


	" A Vim Plugin for Lively Previewing LaTeX PDF Output
  " ~/.vim/plugin/latex/vim-latex-live-preview.vim
  " 暂时不用，如果需要用的话要到 ~/.vim/plugin/latex/vim-latex-live-preview.vim 文件中修改livepreview_engine
	" Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }	" 用pdf软件实时预览latex文档的编写

  " 调试
  " Plug 'IammyselfYBX/termdebug'
  
  "======================================
  "     Undo-tree 
  "======================================
  Plug 'mbbill/undotree'
  "======================================
  " 1.配置文件: ~/.vim/plugin/undotree.vim
  "======================================
  
  "======================================
  "     github copilot 
  "======================================
  Plug 'github/copilot.vim'
  "======================================
  " 1.配置文件: ~/.vim/plugin/github-copilot.vim
  "======================================

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