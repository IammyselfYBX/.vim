" 插件管理
" 所有 GitHub 插件统一通过 SSH 拉取；详细依赖见 ~/.vim/doc/plugins.md

let g:plug_url_format = 'git@github.com:%s.git'
let g:coc_config_home = expand('~/.vim')
let g:coc_data_home = expand('~/.vim/plugged/coc')

" 优先使用用户目录中的 Node；没有时回退到系统 node/npm
let s:local_node_bin = expand('~/.local/opt/node/bin')
if executable(s:local_node_bin . '/node')
  let g:coc_node_path = s:local_node_bin . '/node'
  let $PATH = s:local_node_bin . ':' . $PATH
endif

function! s:InstallMarkdownPreview()
  if !executable('node') || !executable('npm')
    echohl WarningMsg
    echomsg 'markdown-preview: 需要 Node.js 和 npm，已跳过依赖安装'
    echohl None
    return
  endif

  try
    call mkdp#util#install()
  catch
    echohl WarningMsg
    echomsg 'markdown-preview: 依赖安装失败: ' . v:exception
    echohl None
  endtry
endfunction

" 只在 vim-plug 自身缺失时下载一次，避免每次启动都访问网络
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged/vim-plug')
  Plug 'junegunn/vim-plug'

  " 状态栏
  Plug 'vim-airline/vim-airline'

  " 彩虹括号
  Plug 'IammyselfYBX/vim-rainbow'

  " 文件树
  Plug 'preservim/nerdtree', {'on': 'NERDTreeToggle'}
  Plug 'Xuyuanp/nerdtree-git-plugin'

  " 符号列表；依赖 Universal Ctags
  Plug 'preservim/tagbar'

  " 异步执行编译命令
  Plug 'skywind3000/asyncrun.vim'

  " 语法检查
  Plug 'dense-analysis/ale'

  " 代码补全、LSP 与 Snippet 客户端
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " 模糊搜索
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  " Markdown 预览与表格编辑
  " mkdp#util#install() 属于 Markdown Preview，不应挂在 vim-table-mode 上
  Plug 'iamcco/markdown-preview.nvim',
        \ {'do': { -> s:InstallMarkdownPreview() }, 'for': ['markdown', 'vim-plug']}
  Plug 'iamcco/mathjax-support-for-mkdp', {'for': 'markdown'}
  Plug 'dhruvasagar/vim-table-mode', {'for': 'markdown'}

  " Glow 存在时才启用，避免无依赖机器出现无效插件
  if executable('glow')
    Plug 'jclsn/glow.vim'
  endif

  " 撤销树
  Plug 'mbbill/undotree'

  " 可选插件，需要时再启用
  " Plug 'xuhdev/vim-latex-live-preview', {'for': 'tex'}
  " Plug 'wolandark/vim-live-server'
  " Plug 'github/copilot.vim'
call plug#end()
