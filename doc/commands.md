# 命令速查

这里列出本配置直接涉及的 Vim、插件管理和常用内建命令。Vim 内建命令的完整列表见 `:help index`。

## 1. 配置与插件管理

| 命令 | 作用 |
|---|---|
| `:source $MYVIMRC` | 重新加载主配置 |
| `:PlugInstall` | 安装 `plugins.vim` 中声明但尚未安装的插件 |
| `:PlugUpdate` | 更新 vim-plug 插件 |
| `:PlugClean` | 删除已从配置中移除的插件 |
| `:PlugStatus` | 查看插件安装状态 |
| `:PlugDiff` | 查看插件更新差异 |
| `:packadd iciba-translate` | 加载金山翻译插件 |
| `:packadd vim-live-server` | 加载 live-server 插件 |
| `:ClearSwapdir` | 打开 swap 文件清理菜单 |
| `:AsyncLatex` | 在包含 `main.tex` 的项目根目录执行 latexmk |

## 2. COC

| 命令 | 作用 |
|---|---|
| `:CocConfig` | 打开用户配置 `~/.vim/coc-settings.json` |
| `:CocLocalConfig` | 创建或打开项目本地 `.vim/coc-settings.json` |
| `:CocInstall coc-pyright` | 安装 Python 语言客户端 |
| `:CocInstall coc-clangd` | 安装 clangd 的 COC 客户端 |
| `:CocUninstall <extension>` | 卸载扩展 |
| `:CocUpdate` | 更新全部 COC 扩展 |
| `:CocList extensions` | 查看已安装扩展 |
| `:CocList commands` | 查看扩展贡献的命令 |
| `:CocCommand` | 执行 COC 命令 |
| `:CocDiagnostics` | 查看当前 buffer 的诊断 |
| `:CocRestart` | 重启 COC 服务 |
| `:CocInfo` | 查看 COC 环境信息 |
| `:CocAction('doHover')` | 显示当前符号文档 |
| `:CocAction('format')` | 调用 LSP 格式化当前文件 |

## 3. fzf

| 命令 | 作用 |
|---|---|
| `:FZF` | 搜索文件 |
| `:Buffers` | 搜索打开的 buffer |
| `:History` | 搜索历史 |
| `:History:` | 命令历史 |
| `:History/` | 搜索历史 |
| `:Windows` | 窗口列表 |
| `:Maps` | 快捷键列表 |
| `:Colors` | 配色列表 |
| `:Helptags` | 帮助标签列表 |
| `:Rg <pattern>` | 使用 ripgrep 搜索项目内容 |
| `:Ag <pattern>` | 使用 ag 搜索；当前机器没有 ag，优先使用 `:Rg` |
| `:GFiles` | Git 跟踪文件 |
| `:GFiles?` | Git 状态文件 |

## 4. NERDTree / Tagbar / UndoTree

| 命令 | 作用 |
|---|---|
| `:NERDTree` | 打开 NERDTree |
| `:NERDTreeToggle` | 打开/关闭 NERDTree |
| `:NERDTreeFocus` | 聚焦 NERDTree |
| `:NERDTreeFind` | 在当前文件位置打开 NERDTree |
| `:TagbarToggle` | 打开/关闭 Tagbar |
| `:TagbarOpen` | 打开 Tagbar |
| `:TagbarClose` | 关闭 Tagbar |
| `:UndotreeToggle` | 打开/关闭 UndoTree |
| `:UndotreeShow` | 显示 UndoTree |
| `:UndotreeHide` | 隐藏 UndoTree |
| `:UndotreeFocus` | 聚焦 UndoTree |

## 5. AsyncRun

| 命令 | 作用 |
|---|---|
| `:AsyncRun <cmd>` | 异步执行命令 |
| `:AsyncRun! <cmd>` | 执行并立即打开 Quickfix |
| `:AsyncStop` | 停止当前异步任务 |
| `:AsyncStop!` | 强制停止当前任务 |
| `:call asyncrun#quickfix_toggle(6)` | 切换 Quickfix 窗口 |

## 6. ALE

| 命令 | 作用 |
|---|---|
| `:ALELint` | 立即检查当前文件 |
| `:ALEToggle` | 打开/关闭 ALE |
| `:ALEFix` | 尝试自动修复 |
| `:ALEInfo` | 查看 ALE 配置和 linter 状态 |
| `:ALEGoToDefinition` | 跳转到定义 |
| `:ALEFindReferences` | 查找引用 |

## 7. Markdown Preview / vim-table-mode / Glow

| 命令 | 作用 |
|---|---|
| `:MarkdownPreview` | 启动 Markdown 预览 |
| `:MarkdownPreviewStop` | 停止 Markdown 预览 |
| `:MarkdownPreviewToggle` | 打开/关闭 Markdown 预览 |
| `:TableModeToggle` | 打开/关闭表格模式 |
| `:TableModeRealign` | 重新对齐表格 |
| `:Tableize` | 将选中文本转换为表格 |
| `:TableToHTML` | 表格转 HTML |
| `:TableToLaTeX` | 表格转 LaTeX |
| `:Glow` | 在当前窗口渲染 Markdown |
| `:Glowsplit` | 分屏渲染 Markdown |
| `:Glowpop` | 弹窗渲染 Markdown |

## 8. Live Server 与翻译

加载 `vim-live-server` 后：

| 命令 | 作用 |
|---|---|
| `:StartLiveServer` | 启动 live-server |
| `:StartLiveServerOnPort 8080` | 指定端口启动 |
| `:KillLiveServer` | 停止 live-server |
| `:StartBrowserSync` | 启动 browser-sync |
| `:StartBrowserSyncOnPort 3000` | 指定端口启动 |
| `:KillBrowserSync` | 停止 browser-sync |
| `:LIVEToggle` | 启动/停止服务 |

加载 `iciba-translate` 后：

| 命令 | 作用 |
|---|---|
| `:Ici <word>` | 查询英文单词 |
| `:IciFrom` | 查询光标下单词 |

## 9. 常用 Vim 内建命令

| 命令 | 作用 |
|---|---|
| `:w` / `:q` / `:wq` | 保存 / 退出 / 保存并退出 |
| `:qa!` | 强制退出全部窗口 |
| `:e <file>` | 打开文件 |
| `:sp` / `:vsp` | 水平 / 垂直分屏 |
| `:tabnew` | 新建 tab |
| `:term` | 打开终端 |
| `:bd` | 关闭 buffer |
| `:reg` | 查看寄存器 |
| `:marks` | 查看标记 |
| `:map` / `:nmap` / `:imap` | 查看映射 |
| `:verbose map <key>` | 查看快捷键由哪个文件定义 |
| `:command` | 查看用户命令 |
| `:scriptnames` | 查看已加载脚本顺序 |
| `:messages` | 查看消息历史 |
| `:set` / `:setlocal` | 查看或设置选项 |
| `:checkhealth` | Neovim 健康检查，Vim 不支持 |
