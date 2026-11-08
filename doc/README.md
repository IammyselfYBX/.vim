# Vim 配置文档

本目录记录本仓库的按键、命令、插件依赖和 COC 管理方式。

## 文档索引

- [快捷键与冲突](keymaps.md)：本配置定义的全部快捷键、插件常用快捷键和覆盖关系。
- [命令速查](commands.md)：Vim、vim-plug、COC、fzf、ALE、Tagbar 等命令。
- [插件说明](plugins.md)：插件功能、依赖、安装方式和当前机器状态。
- [COC 与语言服务器](coc.md)：COC 配置目录、clangd/ccls 选择和 ctags 的关系。
- [目录与文件说明](directories.md)：`autoload`、`configs`、`pack` 等逐项说明。

## 目录约定

```text
~/.vim/
├── .vimrc                 # 主入口
├── init.lua               # Neovim 主入口
├── init.vim               # Neovim 兼容入口
├── autoload/              # vim-plug 自举文件
├── colors/                # 配色方案
├── configs/
│   ├── vim/               # Vimscript 配置模块
│   └── neovim/            # Neovim Lua 配置模块
├── plugin/                # Vim 启动时加载的插件配置
├── pack/                  # Vim 原生 opt 插件
├── plugged/
│   ├── coc/               # COC 扩展、MRU 和缓存
│   ├── vim-plug/          # vim-plug 管理的插件
│   └── README.md          # 目录约定说明
├── script/                # 环境检查脚本
├── doc/                   # 本套文档
├── YBXUltiSnips/          # 自定义 snippet
├── swap/                  # swap 文件
└── undodir/               # 持久化撤销历史
```

`plugged/coc` 和 `plugged/vim-plug` 由插件管理器创建，不进入 Git。

## GitHub 插件源

本仓库统一使用 GitHub SSH 地址：

```vim
let g:plug_url_format = 'git@github.com:%s.git'
```

远程主机建议在 `~/.ssh/config` 中保留：

```sshconfig
Host github.com
  HostName ssh.github.com
  User git
  IdentityFile ~/.ssh/id_rsa
  Port 443
```

验证：

```bash
ssh -T git@github.com
git ls-remote git@github.com:junegunn/vim-plug.git HEAD
```

## 插件安装与更新

```vim
:PlugInstall
:PlugUpdate
:PlugClean
:PlugStatus

:CocInstall coc-pyright
:CocUpdate
:CocList extensions
```

国内 npm 环境建议在 `~/.npmrc` 同时设置：

```ini
registry=https://registry.npmmirror.com/
coc.nvim:registry=https://registry.npmmirror.com/
```

## COC 路径

```vim
let g:coc_config_home = expand('~/.vim')
let g:coc_data_home = expand('~/.vim/plugged/coc')
```

- 配置文件：`~/.vim/coc-settings.json`
- 扩展与数据：`~/.vim/plugged/coc/`

## 维护规则

1. 修改 Vim 行为时优先改 `configs/vim/`。
2. 修改 Neovim 专属行为时改 `configs/neovim/`。
3. 插件专属配置放 `plugin/`。
4. 新增快捷键后同步更新 `doc/keymaps.md`。
5. 新增插件后同步更新 `doc/plugins.md` 中的功能、依赖和安装方式。
6. `autocmd` 必须放进带 `autocmd!` 的 `augroup`，避免重复 `:source` 后重复注册。
7. 系统剪贴板没有启用是有意选择；终端中继续使用 `Ctrl+Shift+C/V`。
