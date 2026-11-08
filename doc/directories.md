# 目录与文件说明

## `autoload/`

`autoload/` 存放 Vim/Neovim 按需加载的脚本。

当前只有：

```text
autoload/plug.vim
```

这是 vim-plug 本体。`configs/vim/plugins.vim` 中的 `plug#begin()`、`Plug`、`plug#end()` 都由它实现；Vim 和 Neovim 共用这一份插件声明。

特点：

- 不要直接修改这个文件。
- 更新 vim-plug 使用 `:PlugUpdate`。
- 删除它以后，下一次启动会尝试从 GitHub 下载。
- 只保留一个文件是 vim-plug 的正常官方结构，不需要拆成多个文件。

## `autoload/plug.vim` 的优化空间

只保留一个 `plug.vim` 本身不是性能问题。真正影响启动速度的是插件的加载数量和加载时机。

可选优化方案：

1. 对 Tagbar、UndoTree 等插件使用 `on` 延迟加载。
2. 对 Markdown、LaTeX 等插件使用 `for` 按文件类型加载。
3. 对 fzf 命令使用 `on` 或 `cmd` 延迟加载。
4. 用 `vim --startuptime /tmp/vim-startup.log` 找到实际耗时最高的插件。
5. Neovim 可以单独使用 lazy.nvim；Vim 继续使用 vim-plug。

不建议把 `autoload/plug.vim` 手工拆分。那样会增加升级和维护成本，但启动速度提升通常很小。

## `configs/`

`configs/` 分为 Vim 和 Neovim 两套入口配置。

```text
configs/
├── vim/
│   ├── shortcut-key.vim
│   ├── surface.vim
│   ├── file-setup.vim
│   ├── split-screen.vim
│   ├── customize.vim
│   ├── my-function.vim
│   ├── terminal-emulator.vim
│   ├── plugins.vim
│   ├── programming-environment.vim
│   ├── compile-run.vim
│   └── debug.vim
└── neovim/
    ├── init.lua
    └── presenting.lua
```

### `configs/vim/`

这是 Vim 的主要配置目录，由 `/home/tony/.vim/.vimrc` 加载。

| 文件 | 作用 |
|---|---|
| `shortcut-key.vim` | 全局快捷键、Leader、保存、退出、刷新配置、全文缩进 |
| `surface.vim` | 主题、缩进、换行、光标形状 |
| `file-setup.vim` | 编码、swap、undo、文件类型 |
| `split-screen.vim` | 分屏与窗口切换 |
| `customize.vim` | 搜索、折叠、括号补全、tab |
| `my-function.vim` | 自定义函数和命令，例如 `:ClearSwapdir` |
| `terminal-emulator.vim` | Vim 内置终端快捷键 |
| `plugins.vim` | Vim 的 vim-plug 声明、COC 目录、Node 路径 |
| `programming-environment.vim` | Ctags、Cscope、编程环境说明 |
| `compile-run.vim` | 编译、运行、CMake、Conda、CUDA、Markdown/TeX 预览 |
| `debug.vim` | F8 编译并启动 Termdebug |

### `configs/neovim/`

这是 Neovim 的 Lua 专属配置目录。根级 `/home/tony/.vim/init.lua` 先加载共享的 `.vimrc`，再加载这里的 Lua 文件，因此不需要把 Vimscript 重写一遍。

| 文件 | 作用 |
|---|---|
| `init.lua` | Neovim 专属 Lua 入口 |
| `presenting.lua` | presenting.nvim、nvim-treesitter、treesitter-context |

Neovim 会复用 `configs/vim/` 中的全部通用行为与插件声明，避免把编译、调试、快捷键和插件列表复制两份。`configs/neovim/` 只保留必须使用 Lua 的 Neovim 专属逻辑。

## `pack/`

`pack/` 是 Vim 原生 package 目录，不依赖 vim-plug。

当前有两个可选插件：

```text
pack/UtilityPlugin/opt/iciba-translate
pack/WebDev/opt/vim-live-server
```

它们放在 `opt` 下，不会在启动时自动加载，需要手动执行：

```vim
:packadd iciba-translate
:packadd vim-live-server
```

### `iciba-translate`

功能：

- `:Ici word`：查询单词
- `:IciFrom`：查询光标下单词

依赖：

- Python 3
- 可访问 `dict-co.iciba.com`
- 插件内硬编码了第三方 API Key

注意：它使用 HTTP 而不是 HTTPS，并且 API Key 写在 Git 仓库文件中，不建议公开分享该文件。

### `vim-live-server`

功能：

- HTML/CSS/JS 热更新预览
- 启动/停止 `live-server` 或 `browser-sync`

依赖：

- Node.js
- npm
- `live-server` 或 `browser-sync`

安装：

```bash
npm install -g live-server browser-sync
```

加载后可以使用：

```vim
:StartLiveServer
:StartBrowserSync
:LIVEToggle
```

对应快捷键：

```text
F3
```

`F3` 只有在执行 `:packadd vim-live-server` 后才会出现。

## `plugged/`

```text
plugged/vim-plug/   # vim-plug 管理的插件
plugged/coc/        # COC 扩展和数据
```

这两个目录由插件管理器创建，不进入 Git。

## 其他顶层文件

| 文件 | 作用 |
|---|---|
| `.vimrc` | Vim 主配置入口；Neovim 调用时会转到 Lua 入口 |
| `init.lua` | Neovim 主入口，加载共享 `.vimrc` 后执行 `configs/neovim/init.lua` |
| `init.vim` | Neovim 兼容入口，转到 `init.lua` |
| `README.md` | 仓库总览 |
| `coc-settings.json` | COC 用户配置 |
| `colors/` | 配色方案 |
| `plugin/` | Vim/Neovim 启动时自动加载的插件配置 |
| `doc/` | 快捷键、命令、插件、COC 和目录文档 |
| `YBXUltiSnips/` | 自定义代码片段 |
| `swap/` | swap 文件 |
| `undodir/` | 持久化撤销历史 |
