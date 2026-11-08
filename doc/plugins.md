# 插件功能、依赖与安装

## 目录约定

```text
~/.vim/plugged/vim-plug/   vim-plug 管理的插件
~/.vim/plugged/coc/        COC 扩展、MRU、缓存
```

所有 GitHub 插件使用：

```vim
let g:plug_url_format = 'git@github.com:%s.git'
```

安装：

```vim
:PlugInstall
```

## 插件总表

| 插件 | 功能 | 配置文件 | 外部依赖 |
|---|---|---|---|
| vim-plug | 插件管理器 | `autoload/plug.vim`、`vimconfigs/plugins.vim` | git、curl；首次安装需要网络 |
| vim-airline | 状态栏 | `plugin/airline.vim` | 无；Nerd Font 可选 |
| vim-rainbow | 彩虹括号 | `plugin/vim-rainbow.vim` | 无 |
| NERDTree | 文件树 | `plugin/nerdtree/nerdtree.vim` | Vim；Git 状态插件需要 git |
| nerdtree-git-plugin | 文件树 Git 状态 | `plugin/nerdtree/nerdtree-git.vim` | git |
| Tagbar | 函数/类/变量符号列表 | `plugin/tagbar.vim` | Universal Ctags |
| AsyncRun | 异步命令、编译和 Quickfix | `plugin/asyncrun.vim` | Vim `+job`/`+terminal` |
| ALE | 异步语法检查 | `plugin/ale.vim` | 可选外部 linter，如 gcc、ccls、clangd |
| coc.nvim | 补全、LSP、诊断、代码操作 | `plugin/coc.vim`、`coc-settings.json` | Node.js、npm |
| coc-clangd | clangd 的 COC 客户端 | COC 扩展目录 | clangd 可执行文件 |
| coc-pyright | Python 类型检查与补全 | COC 扩展目录 | Node.js；Python 解释器可选 |
| fzf | 模糊查找核心 | `plugin/fzf.vim` | fzf 可执行文件 |
| fzf.vim | 文件、Buffer、历史等查找命令 | `plugin/fzf.vim` | fzf；rg 或 ag 用于内容搜索 |
| Markdown Preview | Markdown 浏览器预览 | `plugin/markdown/markdown-preview-for-vim.vim` | Node.js、npm；浏览器 |
| mathjax-support-for-mkdp | Markdown 数学公式支持 | Markdown Preview | Markdown Preview |
| vim-table-mode | Markdown/文本表格编辑 | `plugin/markdown/vim-table-mode.vim` | 无 |
| glow.vim | 终端渲染 Markdown | 无独立配置 | glow 可执行文件 |
| undotree | 撤销历史可视化 | `plugin/undotree.vim` | Vim `+persistent_undo` |
| presenting.nvim | Neovim 幻灯片 | `plugin/markdown/presenting.lua` | Neovim |
| nvim-treesitter | Neovim 语法高亮 | Neovim 配置 | Neovim、tree-sitter 编译器 |
| vim-latex-live-preview | LaTeX 实时预览 | `plugin/latex/vim-latex-live-preview.vim` | latexmk/xelatex、zathura；当前插件声明被注释 |
| vim-live-server | HTML/CSS/JS 热更新 | `pack/WebDev/opt/vim-live-server` | Node.js、live-server/browser-sync |
| iciba-translate | 金山词霸查词 | `pack/UtilityPlugin/opt/iciba-translate` | Python 3、联网 |

## 依赖安装

### Arch Linux

```bash
sudo pacman -S git curl nodejs npm
sudo pacman -S fzf ripgrep
sudo pacman -S ctags
sudo pacman -S clang ccls
sudo pacman -S glow
sudo pacman -S zathura zathura-pdf-poppler
sudo pacman -S texlive-core texlive-latexextra
```

CUDA 机器额外安装与驱动匹配的 CUDA Toolkit：

```bash
sudo pacman -S cuda
```

不要在不含 NVIDIA GPU 的机器安装 CUDA。

### Debian / Ubuntu

```bash
sudo apt install git curl nodejs npm
sudo apt install fzf ripgrep universal-ctags
sudo apt install clang clangd ccls
sudo apt install glow
sudo apt install zathura zathura-pdf-poppler
sudo apt install latexmk texlive-xetex
```

### 可选命令

```bash
# ag，只用于 :Ag；已经安装 rg 时不是必需
sudo pacman -S the_silver_searcher

# live-server / browser-sync
npm install -g live-server browser-sync
```

## COC 扩展

`plugin/coc.vim` 当前自动安装：

```vim
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-snippets',
  \ 'coc-clangd',
  \ 'coc-pyright',
  \ ]
```

手动安装：

```vim
:CocInstall coc-pyright
:CocInstall coc-clangd
```

COC 扩展不要用 vim-plug 安装；COC 自己通过 npm 管理扩展。

## npm registry

COC 扩展使用 npm，因此国内环境建议在 `~/.npmrc` 添加：

```ini
coc.nvim:registry=https://registry.npmmirror.com/
```

这只影响 COC 的 npm 安装，不改变其他 npm 项目。

## Markdown Preview 安装钩子

`mkdp#util#install()` 是 Markdown Preview 的安装函数，不是 `vim-table-mode` 的函数。

当前配置：

```vim
Plug 'iamcco/markdown-preview.nvim',
      \ {'do': { -> s:InstallMarkdownPreview() }, 'for': ['markdown', 'vim-plug']}
Plug 'iamcco/mathjax-support-for-mkdp', {'for': 'markdown'}
Plug 'dhruvasagar/vim-table-mode', {'for': 'markdown'}
```

`vim-table-mode` 不挂 `mkdp#util#install()`。安全钩子只属于 Markdown Preview，并且会先检查 Node.js/npm 是否可用。

## Tagbar、ctags 与 COC 的关系

- COC 提供 LSP 级别的定义、引用、诊断，**可以替代 ctags 在代码导航中的很多用途**。
- Tagbar 专门依赖 Universal Ctags 生成符号索引，COC 不会自动为 Tagbar 提供符号列表。
- 如果你不使用 Tagbar，可以不安装 ctags。
- 如果保留 `F9` Tagbar，就必须安装 Universal Ctags。

详见 [COC 与语言服务器](coc.md)。

## 系统状态检查

```vim
:PlugStatus
:checkhealth
:CocInfo
:ALEInfo
:echo executable('ctags')
:echo executable('clangd')
:echo executable('ccls')
:echo executable('conda')
:echo executable('node')
```
