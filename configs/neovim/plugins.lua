-- Neovim plugin declarations
-- 与 Vim 共用 ~/.vim/plugged/vim-plug，但这里只声明 Neovim 需要的插件集合。

vim.g.plug_url_format = 'git@github.com:%s.git'

vim.cmd([[
function! NeovimInstallMarkdownPreview()
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
]])

vim.cmd([[call plug#begin('~/.vim/plugged/vim-plug')]])
vim.cmd([[Plug 'junegunn/vim-plug']])
vim.cmd([[Plug 'vim-airline/vim-airline']])
vim.cmd([[Plug 'IammyselfYBX/vim-rainbow']])
vim.cmd([[Plug 'preservim/nerdtree', {'on': 'NERDTreeToggle'}]])
vim.cmd([[Plug 'Xuyuanp/nerdtree-git-plugin']])
vim.cmd([[Plug 'preservim/tagbar']])
vim.cmd([[Plug 'skywind3000/asyncrun.vim']])
vim.cmd([[Plug 'dense-analysis/ale']])
vim.cmd([[Plug 'neoclide/coc.nvim', {'branch': 'release'}]])
vim.cmd([[Plug 'junegunn/fzf']])
vim.cmd([[Plug 'junegunn/fzf.vim']])
vim.cmd([[Plug 'iamcco/markdown-preview.nvim', {'do': { -> NeovimInstallMarkdownPreview() }, 'for': ['markdown', 'vim-plug']}]])
vim.cmd([[Plug 'iamcco/mathjax-support-for-mkdp', {'for': 'markdown'}]])
vim.cmd([[Plug 'dhruvasagar/vim-table-mode', {'for': 'markdown'}]])
vim.cmd([[Plug 'sotte/presenting.nvim']])
vim.cmd([[Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}]])
vim.cmd([[Plug 'nvim-treesitter/nvim-treesitter-context']])
vim.cmd([[Plug 'mbbill/undotree']])
vim.cmd([[call plug#end()]])
