# COC 与语言服务器

## 1. 配置目录

当前统一放在 `~/.vim`：

```vim
let g:coc_config_home = expand('~/.vim')
let g:coc_data_home = expand('~/.vim/plugged/coc')
```

对应关系：

| 内容 | 路径 |
|---|---|
| 用户配置 | `~/.vim/coc-settings.json` |
| COC 扩展 | `~/.vim/plugged/coc/extensions/` |
| MRU、缓存等运行数据 | `~/.vim/plugged/coc/` |

`g:coc_config_home` 是“配置文件目录”，`g:coc_data_home` 是“运行数据目录”，两者不要混淆。

`plugged/coc` 不进入 Git。换机器时只同步 `coc-settings.json`，扩展在新机器上重新安装。

## 2. COC 扩展安装

```vim
:CocInstall coc-json
:CocInstall coc-tsserver
:CocInstall coc-vimlsp
:CocInstall coc-snippets
:CocInstall coc-pyright
:CocInstall coc-clangd
```

已经写入 `g:coc_global_extensions` 的扩展会在 COC 启动时自动检查。

## 3. npm 国内源

在 `~/.npmrc` 增加：

```ini
registry=https://registry.npmmirror.com/
coc.nvim:registry=https://registry.npmmirror.com/
```

更新：

```vim
:CocUpdate
```

查看：

```vim
:CocList extensions
:CocInfo
```

## 4. clangd、ccls、coc-clangd、coc-ccls 的区别

这是四个不同层面的东西：

| 名称 | 类型 | 是否需要 |
|---|---|---|
| `clangd` | LLVM 官方 C/C++ Language Server 可执行文件 | 使用 clangd 时必须有 |
| `ccls` | 独立的 C/C++/CUDA Language Server 可执行文件 | 使用 ccls 时必须有 |
| `coc-clangd` | COC 的 clangd 客户端扩展 | 用 clangd 时推荐 |
| `coc-ccls` | COC 的 ccls 客户端扩展 | 用 ccls 时推荐 |

### clangd 的特点

优点：

- LLVM 官方项目，维护活跃，版本更新稳定。
- 对现代 C++、诊断、Clang-Tidy、补全和 quick fix 支持好。
- 通常能自动识别系统头文件。
- 与 `compile_commands.json` 配合成熟。

不足：

- 大型项目后台索引有时比 ccls 更吃资源。
- CUDA 支持依赖正确的编译参数，配置不当会误报。
- 某些重索引/全局关系操作不如 ccls 灵活。

### ccls 的特点

优点：

- 面向 C/C++ 项目索引，跨文件引用、继承关系、全局符号理解较强。
- 对 CUDA 有显式支持，适合大型 C/C++/CUDA 工程。
- 索引完成后，全局跳转和引用效率较高。

不足：

- 独立项目，生态和维护节奏不如 LLVM 官方 clangd。
- 初次索引可能占用较多 CPU、内存和磁盘。
- 现代 C++ quick fix、Clang-Tidy 集成通常不如 clangd 完整。

### 推荐选择

默认选择 **clangd**，原因是维护稳定、系统集成简单、诊断体验更好。

如果主要工作是大型 CUDA 工程，并且实际测试 ccls 在你的代码上更准确，可以切到 **ccls**。

## 5. 全部使用 ccls 可以吗？

可以。需要同时满足：

1. 系统保留 `ccls` 可执行文件。
2. COC 使用 `coc-ccls`，不要同时启用 `coc-clangd`。
3. ALE 的 C/C++ linter 继续使用 `ccls`，或保持为空，避免重复诊断。
4. `coc-settings.json` 中不要再保留指向 clangd 的配置。

示例：

```vim
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-snippets',
  \ 'coc-ccls',
  \ 'coc-pyright',
  \ ]
```

如果全部使用 ccls，且没有其他软件调用 clangd，可以从系统移除 clangd。但建议先保留一段时间作为备用：

- 删除 clangd 不会提升编译速度。
- 只会减少磁盘占用。
- 如果某个项目在 ccls 下索引异常，clangd 可以作为回退。

## 6. 当前配置：全部使用 clangd

当前机器已移除 ccls，只保留 clangd 23.1.1。默认配置使用：

```text
coc-clangd + clangd
```

同时，`plugin/ale.vim` 已将 C/C++/CUDA 的 ALE linter 设为空列表，由 COC 的 clangd 统一负责诊断和导航。这样不会同时启动 clangd 与 ccls，也不会重复检查同一个文件。

因此，当前配置不再依赖 ccls，系统 ccls 已经移除。移除 ccls 不会提升 Vim 启动速度；它只影响 ccls 语言服务器本身，减少的是磁盘占用和潜在资源占用。

clangd 并不在所有方面都绝对优于 ccls。ccls 仍有大型项目索引和 CUDA 工程方面的优势；但对当前单机日常 C/C++/CUDA 使用，clangd 的官方维护、诊断和配置体验更适合作为唯一 LSP。

## 7. ctags 与 COC 的关系

安装 COC 后，C/C++ 的定义跳转、引用和诊断可以由 LSP 完成，所以：

- 不使用 Tagbar：可以不安装 ctags。
- 使用 Tagbar：仍然需要 Universal Ctags。
- 使用 Vim 原生 `:tags`、`<C-]>` 等 tag 功能：仍然需要 ctags。

也就是说，COC 能替代“部分 ctags 导航功能”，但不能替代 Tagbar 这个插件本身。

## 8. 项目级配置

项目级配置应跟随项目：

```text
项目根目录/.vim/coc-settings.json
```

创建：

```vim
:CocLocalConfig
```

适合项目专用内容：

- Python 解释器
- include 路径
- compile_commands.json 路径
- clangd 参数
- 项目专用诊断规则

不要把所有项目配置都塞进 `~/.vim/coc-settings.json`。
