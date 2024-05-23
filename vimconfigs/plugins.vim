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
  "     vim-rainbow
  "======================================
  Plug 'IammyselfYBX/vim-rainbow'
  "======================================
	"vim-rainbow ~/.vim/plugin/vim-rainbow.vim
  " :RainbowToggle  打开/关闭 Rainbow 插件
  " :RainbowLoad    加载/重新加载 Rainbow 插件

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
  " <F5> 打开/关闭undotree

  "======================================
  "     LargeFile
  "======================================
  " 在文件较大时自动关闭事件处理、撤销、语法加亮等功能，
  " 用来换取更快的处理速度和更短的响应时间。
  "Plug 'vim-script/LargeFile'
  "======================================
  
  "======================================
  "     vim-live-server
  "======================================
  " 1.安装依赖
  "   sudo npm install -g live-server
  "   sudo npm install -g browser-sync
  " Plug 'https://github.com/wolandark/vim-live-server.git'
  " Plug 'wolandark/vim-live-server'
  "======================================

  "======================================
  "     github copilot 
  "======================================
  Plug 'github/copilot.vim'
  "======================================
  " 1.配置文件: ~/.vim/plugin/github-copilot.vim
  "======================================

call plug#end()





" 可以按 gf 跳转到该文件
