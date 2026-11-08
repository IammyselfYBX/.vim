# 目录与文件说明

## `autoload/`

`autoload/` 存放 Vim 按需加载的脚本。

当前只有：

```text
autoload/plug.vim
```

这是 vim-plug 本体。`vimconfigs/plugins.vim` 中的 `plug#begin()`、`Plug`、`plug#end()` 都由它实现。

特点：

- Vim 启动时不会完整执行所有函数，而是在调用 `plug#...` 时加载。
- 不要直接修改这个文件。
- 更新 vim-plug 应使用 `:PlugUpdate`，不要手工覆盖。
- 如果删除它，下一次启动会尝试从 GitHub 下载。

## `ignore_count.txt`

这是之前 `main` 二进制程序的忽略目录配置，用于统计代码行数时排除：

```text
autoload
colors
pack
plugged
swap
.git
undodir
README.md
```

`main` 已经从 Git 仓库移除，因此 `ignore_count.txt` 目前是孤立文件，不再被 Vim 或任何插件读取。

它现在可以安全删除；保留也不会影响 Vim。

## `coc-settings.json.back`

这是 `coc-settings.json` 的旧备份，不会被 COC 自动加载。

真正的用户配置是：

```text
~/.vim/coc-settings.json
```

`coc-settings.json.back` 只在需要手动对比旧配置时有用。确认旧内容不再需要后可以删除。

## `vimconfigs/`

这是本配置的主要模块目录，由 `.vimrc` 按顺序 `source`。

| 文件 | 作用 |
|---|---|
| `shortcut-key.vim` | 全局快捷键、Leader、保存、退出、配置刷新 |
| `surface.vim` | 主题、缩进、换行、行号、光标形状 |
| `file-setup.vim` | 编码、swap、undo、文件类型 |
| `split-screen.vim` | 分屏与窗口切换 |
| `customize.vim` | 搜索、折叠、括号补全、tab 操作 |
| `my-function.vim` | 自定义函数和命令，例如 `:ClearSwapdir` |
| `terminal-emulator.vim` | 内置终端快捷键 |
| `plugins.vim` | vim-plug、插件声明、COC 目录、Node 路径 |
| `programming-environment.vim` | C、Ctags、Cscope、Python 编程环境说明 |
| `compile-run.vim` | 编译、运行、CMake、Conda、CUDA、Markdown/TeX 预览 |
| `debug.vim` | F8 编译并启动 Termdebug |
| `plugins.lua` | 预留的 Neovim/Lua 配置，目前为空 |

### 加载顺序

`/home/tony/.vim/.vimrc` 中的顺序是：

```text
shortcut-key
surface
file-setup
split-screen
customize
my-function
terminal-emulator
plugins
programming-environment
compile-run
debug
```

后加载的文件可以覆盖前面的映射，例如 `plugin/` 中的 COC 配置会在 `.vimrc` 之后加载，所以 `<C-h>` 最终由 COC 显示文档接管。

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
plugged/vim-plug/   # vim-plug 插件
plugged/coc/        # COC 扩展和数据
```

这两个目录由插件管理器创建，不进入 Git。

## 其他顶层文件

| 文件 | 作用 |
|---|---|
| `.vimrc` | 主配置入口 |
| `init.vim` | 指向 `.vimrc` 的 Neovim 入口 |
| `README.md` | 仓库总览 |
| `coc-settings.json` | COC 用户配置 |
| `colors/` | 配色方案 |
| `plugin/` | Vim 启动时自动加载的插件配置 |
| `doc/` | 快捷键、命令、插件与目录文档 |
| `YBXUltiSnips/` | 自定义代码片段 |
| `swap/` | swap 文件 |
| `undodir/` | 持久化撤销历史 |
