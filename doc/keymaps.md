# 快捷键与冲突

`<Leader>` 默认为空格键。

## 1. 文件与 Vim 生命周期

| 快捷键 | 模式 | 作用 |
|---|---|---|
| `<C-s>` | Normal / Insert | 保存 |
| `<C-q>` | Normal | 退出当前窗口 |
| `<Leader>r` | Normal | 重新加载 `$MYVIMRC` |
| `<C-S-r>` | Normal | 重新加载配置的兼容别名；部分终端无法区分 Ctrl+Shift+R |
| `w!!` | Command-line | 使用 `sudo tee` 保存无权限文件，输入后还需按 Enter |
| `:ClearSwapdir` | Command-line | 清理 swap 文件 |

## 2. 基础编辑

| 快捷键 | 模式 | 作用 |
|---|---|---|
| `<S-u>` | Normal | Redo，等价于原生 `<C-r>` |
| `<C-u>` | Normal | 撤销整行修改，等价于原生 `U` |
| `$` / `g_` | Normal | 交换“行尾”和“非空白行尾” |
| `<C-a>` | Normal / Insert | 全选 |
| `<C-d>` | Insert | 删除当前行并重新进入插入模式 |
| `<C-x>` | Visual | 删除选区 |
| `--` | Normal | 当前数字减 1 |
| `==` | Normal | 当前数字加 1 |
| `<Space><Space>` | Normal | 跳到下一个 `<++>` 占位符并替换 |
| `(` `[` `{` `'` `"` | Insert | 自动补全配对符号 |
| `)` `]` `}` `>` | Insert | 光标位于相同右符号时自动跳过 |
| `<BS>` | Insert | 光标位于空配对中间时同时删除两侧 |

## 3. 搜索、窗口与分屏

| 快捷键 | 模式 | 作用 |
|---|---|---|
| `<Leader><CR>` | Normal | 清除搜索高亮 |
| `<Leader><Tab>` | Normal | 新建 tab |
| `tn` / `tu` | Normal | 下一个 / 上一个 tab |
| `<C-h>` | Normal | 切换到左侧窗口；当前会被 COC 文档映射覆盖，见冲突表 |
| `<C-j>` / `<C-k>` | Normal | 切换到下 / 上窗口 |
| `<C-l>` | Normal | 切换到右侧窗口 |
| `<C-Up>` / `<C-Down>` | Normal | 跳到最上 / 最下窗口 |
| `<C-w>0` | Normal | 只保留当前窗口 |
| `s<Right>` | Normal | 向右分屏 |
| `s<Left>` | Normal | 向左分屏 |
| `s<Up>` | Normal | 向上分屏 |
| `s<Down>` | Normal | 向下分屏 |
| `sv` | Normal | 横向布局改为纵向 |
| `sh` | Normal | 纵向布局改为横向 |
| `sr` | Normal | 交换窗口位置 |
| `<C-M-Left>` / `<C-M-Right>` | Normal | 调整窗口宽度；部分终端无法发送 |
| `<C-M-Up>` / `<C-M-Down>` | Normal | 调整窗口高度；部分终端无法发送 |

## 4. 终端

| 快捷键 | 模式 | 作用 |
|---|---|---|
| `<Leader>t` | Normal | 打开下方终端 |
| `<Esc>` | Terminal | 退出终端输入模式，进入 Vim Normal 模式 |
| `<C-V><Esc>` | Terminal | 向终端程序发送真实 Esc |

## 5. 编译、运行与预览

| 快捷键 | 文件类型 | 作用 |
|---|---|---|
| `<C-c>` | C/C++/Fortran/CUDA | 编译当前文件 |
| `<C-r>` | C/C++/Fortran/CUDA | 运行对应可执行文件 |
| `<C-p>` | C/C++ | 编译最近的 Makefile/CMake 项目 |
| `<C-r>` | Python | 选择 Conda 环境并运行当前脚本 |
| `<C-c>` | Java | 编译当前 Java 文件 |
| `<C-r>` | Java | 运行当前 Java 类 |
| `<C-r>` | Shell | 执行当前脚本 |
| `<C-r>` | Vim/Zsh/Tmux 配置 | Source 当前文件 |
| `<C-r>` | Markdown | 优先 Markdown Preview，否则使用 Glow |
| `<C-c>` | TeX | 在包含 `main.tex` 的项目根目录执行 `latexmk` |
| `<C-r>` | TeX | 优先 LaTeX live preview，否则执行 latexmk |
| `<C-i>` | HTML | 使用系统浏览器打开 |
| `<F8>` | C/C++ | 同步编译成功后启动 Termdebug |

## 6. 插件快捷键

### NERDTree

| 快捷键 | 作用 |
|---|---|
| `<F2>` | 打开/关闭 NERDTree |
| `?` | NERDTree 帮助 |
| `o` / `Enter` | 打开文件或目录 |
| `t` / `T` | 在新标签页打开 |
| `i` / `s` | 水平 / 垂直分屏打开 |
| `O` | 递归展开目录 |
| `x` / `X` | 关闭父目录 / 递归关闭目录 |
| `p` / `P` | 跳到父目录 / 根目录 |
| `u` / `U` | 上一层目录 / 根目录上一层 |
| `r` / `R` | 刷新节点 / 刷新根节点 |
| `m` | 打开文件操作菜单 |
| `cd` | 切换 Vim 当前目录 |
| `I` / `F` | 显示/隐藏隐藏文件 / 文件 |
| `q` | 关闭 NERDTree |

### Tagbar、UndoTree、AsyncRun

| 快捷键 | 作用 | 依赖 |
|---|---|---|
| `<F9>` | 打开/关闭 Tagbar | Universal Ctags |
| `<F5>` | 打开/关闭 UndoTree | undotree 插件 |
| `<F10>` | 打开/关闭 AsyncRun Quickfix | asyncrun.vim |
| `!` | 进入 `:AsyncRun` 命令模式 | asyncrun.vim |

### fzf

| 快捷键 | 作用 |
|---|---|
| `<C-f>` | 文件搜索 |
| `<C-b>` | Buffer 搜索 |
| `<Leader>h` | 历史记录 |
| `Enter` | 打开选中的结果 |
| `Tab` / `<S-Tab>` | 多选结果 |
| `<C-j>` / `<C-k>` | 在列表中下移 / 上移 |
| `<C-t>` | 在新 tab 打开 |
| `<C-x>` | 水平分屏打开 |
| `<C-v>` | 垂直分屏打开 |
| `<C-y>` | 复制选中路径 |
| `<C-/>` | 查看 fzf 内置按键帮助 |

### COC / LSP

| 快捷键 | 模式 | 作用 |
|---|---|---|
| `<C-o>` | Insert | 刷新补全 |
| `<Tab>` | Insert | 空白处插入缩进，否则刷新补全 |
| `<S-Tab>` | Insert | COC 默认跳转到上一个 snippet 占位符 |
| `<C-j>` | Insert | 展开或跳到下一个 snippet 占位符 |
| `<Tab>` | Visual | 选中 COC snippet 占位符 |
| `<CR>` | Insert | 补全菜单可见时确认；否则执行 `BraceReturn()` |
| `<Leader><Up>` | Normal | 上一个诊断 |
| `<Leader><Down>` | Normal | 下一个诊断 |
| `gd` | Normal | 跳转到定义 |
| `gy` | Normal | 跳转到类型定义 |
| `gi` | Normal | 跳转到实现 |
| `gr` | Normal | 查找引用 |
| `<C-h>` | Normal | 显示当前符号文档；会覆盖“切换到左窗口” |

常用 COC 交互快捷键：

| 快捷键 | 作用 |
|---|---|
| `<C-n>` / `<C-p>` | 补全菜单下一项 / 上一项 |
| `<C-y>` | 确认当前补全项 |
| `<C-e>` | 取消补全菜单 |
| `K` | 部分 LSP 会映射为 hover；本配置未单独设置 |

### vim-table-mode

| 快捷键 | 作用 |
|---|---|
| `<C-\>` | 打开/关闭表格模式；终端可能拦截该组合键，可用 `:TableModeToggle` |
| `\|\|` | 创建表格分隔行 |
| `i\|` / `a\|` | 向前 / 向后插入单元格 |
| `<Leader>tdd` | 删除当前行（是否可用取决于插件版本） |
| `<Leader>tdc` | 删除当前列（是否可用取决于插件版本） |
| `<Leader>tic` | 插入列（是否可用取决于插件版本） |

### Markdown 片段映射

以下映射位于 `YBXUltiSnips/markdown.vim`，只有该文件被 source 后才生效：

| 快捷键 | 内容 |
|---|---|
| `,f` | 跳到下一个 `<++>` 占位符 |
| `,n` | Markdown 分隔线 |
| `,b` | 粗体 |
| `,s` | 删除线 |
| `,i` | 斜体 |
| `,c` | 代码块 |
| `,p` | 图片 |
| `,a` | 链接 |
| `,1` .. `,6` | 一到六级标题 |
| `\|<` | 表格模板 |

### 可选插件

| 快捷键 | 条件 | 作用 |
|---|---|---|
| `<F3>` | `:packadd vim-live-server` 后 | 启动/停止 live-server |
| `<Leader>#$` | LaTeX live preview 插件加载后 | 旧版占位符跳转映射 |

## 7. 覆盖与冲突关系

| 组合键 | 冲突 | 最终生效 |
|---|---|---|
| `<C-h>` | “切换左窗口” vs COC“显示文档” | COC 后加载，显示文档生效 |
| `<C-r>` | 全局“刷新配置” vs 文件类型“运行/执行/source” | 在对应文件类型中运行类映射生效 |
| `<C-a>` | 原生数字自增、插入模式上次文本 vs 全选 | 本配置的全选生效 |
| `<C-d>` | 插入模式原生反缩进 vs 删除整行 | 删除整行生效 |
| `<C-o>` | 插入模式执行一次 Normal 命令 vs COC 刷新 | COC 刷新生效 |
| `<C-j>` | 插入模式换行 vs COC snippet 跳转 | snippet 跳转生效 |
| `<CR>` | 普通换行 vs 补全确认/大括号展开 | `BraceReturn()` 生效 |
| `<Tab>` | 插入制表符 vs 补全刷新 | 非空白位置触发 COC，空白位置插入缩进 |
| `<C-f>` | 原生向下翻页 vs fzf 文件搜索 | fzf 生效 |
| `<C-b>` | 原生向上翻页 vs fzf Buffer 搜索 | fzf 生效 |
| `!` | 原生过滤操作符 vs AsyncRun | Normal 模式下 AsyncRun 生效 |
| `==` | 原生重新缩进当前行 vs 数字加 1 | 数字加 1 生效 |
| `gd` | 原生局部声明跳转 vs COC 定义 | COC 定义生效 |
| `gi` | 原生回到上次插入位置 vs COC 实现 | COC 实现对生效 |
| `gr` | 原生虚拟替换模式 vs COC 引用 | COC 引用生效 |
| `$` / `g_` | 原生行尾语义 | 两者被交换 |
| `<S-u>` / `<C-u>` | 原生 Redo / 半页上移 | 被重新定义 |
| `<C-s>` / `<C-q>` | 终端流控 XOFF/XON | 可能被终端拦截 |
| `<C-\>` | 终端信号/转义组合 vs 表格模式 | 可能被终端拦截 |
| `<C-M-方向键>` | 终端通常无法编码组合键 | 可能完全不可用 |
| `<C-S-r>` | 终端通常无法区分 Ctrl-R 与 Ctrl-Shift-R | 建议使用 `<Leader>r` |

## 8. 设计说明

- `Ctrl+Shift+C/V` 是终端自身的复制粘贴，不属于 Vim 映射。
- 未启用 Vim 系统剪贴板是有意选择，避免 Windows 终端卡顿。
- `<C-r>` 在普通代码缓冲区是“运行”，在 Vim 配置文件中是“source”，这正是文件类型映射覆盖全局映射的结果。
