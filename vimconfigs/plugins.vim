" 用于管理插件
" 如果以后一直到其他系统直接下载vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync |  source $MYVIMRC
endif


" 更多插件见 https://vimawesome.com/
call plug#begin('~/.vim/plugged')
  " 获得vim-plug的帮助手册
  Plug 'junegunn/vim-plug' 
  " let g:plug_url_format='https://git::@hub.fastgit.org/%s.git' "更换国内github加速镜像
  " let g:plug_url_format = 'git@github.com:%s.git' "设置为ssh协议访问
  
  " airline  ~/.vim/plugin/airline.vim
	Plug 'vim-airline/vim-airline'

	"nertree ~/.vim/plugin/nerdtree/nerdtree.vim
  "nerdtree-git  ~/.vim/plugin/nerdtree/nerdtree-git.vim 
  Plug 'https://github.com/preservim/nerdtree',{'on':  'NERDTreeToggle'} " 表明执行NERDTreeToggle才加载插件
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
  Plug 'yelled1/coc-python', {'do': 'yarn install --frozen-lockfile', 'for': 'python'}
    "======================================
    "    COC.nvim
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
  Plug 'dhruvasagar/vim-table-mode', { 'do': { -> mkdp#util#install() }, 'for': 'markdown'}
    "=================vim-table-mode----------
    " 使用说明
    " <C-\> 开启/关闭
    " 1. '[|', ']|', '{|' '}|' 分别表示移动向 left | right | up | down 
    " 2. i| 表示向前插入一个格
    "    a| 表示向后插入一个格
    " 3.<Leader>tdd 删除当前行
    " 4.<Leader>tdc 删除当前列
    " 4.<Leader>tic 前面插入一列


	" A Vim Plugin for Lively Previewing LaTeX PDF Output
  " ~/.vim/plugin/latex/vim-latex-live-preview.vim
	Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }	" 用pdf软件实时预览latex文档的编写

  " 调试
  " Plug 'IammyselfYBX/termdebug'
  
  " Undo-tree ~/.vim/plugin/undotree.vim
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
