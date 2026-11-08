# README
```
__   ________  __  _
\ \ / / __ ) \/ / ( )___
 \ V /|  _ \\  /  |// __|
  | | | |_) /  \    \__ \
  |_| |____/_/\_\   |___/

       _                       ___       _ _         _
__   _(_)_ __ ___  _ __ ___   / (_)_ __ (_) |___   _(_)_ __ ___
\ \ / / | '_ ` _ \| '__/ __| / /| | '_ \| | __\ \ / / | '_ ` _ \
 \ V /| | | | | | | | | (__ / / | | | | | | |_ \ V /| | | | | | |
  \_/ |_|_| |_| |_|_|  \___/_/  |_|_| |_|_|\__(_)_/ |_|_| |_| |_|

```

## 支持平台

本配置支持以下平台：
- Linux (已测试)
- macOS (已适配)
- Windows (部分支持)

配置会自动检测操作系统并应用相应的平台特定设置。

# 目录结构
```
.
├── autoload       # [自带]vim自启动的脚本
│   └── plug.vim   # vim-plug插件(考虑到外网下载速度，就已经自带安装到autoload文件夹中)
├── colors         # 颜色主题
├── configs        # 分平台配置
│   ├── vim        # Vimscript 配置模块
│   └── neovim     # Neovim Lua 配置
├── doc            # 快捷键、命令、插件依赖与 COC 文档
├── pack           # 自定义的插件
│   ├── UtilityPlugin  # 实用工具
│   │    └── opt   # 手动 :packadd 加载插件
│   │        └── iciba-translate # 金山翻译
│   │            ├── plugin # 金山翻译插件代码
│   │            └── syntax # 语法突出显示的 Vim 脚本
│   └── WebDev      # Web开发工具
│       └── opt     # 手动 :packadd 加载插件
│           └── vim-live-server # 实时预览
│               └── plugin # 实时预览插件代码
├── plugged        # 插件运行目录，不进入 Git
│   ├── coc        # COC 扩展与缓存
│   └── vim-plug   # vim-plug 安装的插件
├── script         # 环境检查与辅助脚本
├── plugin         # [自带]vim自启动时加载的插件(这里存放如何设置vim-plug安装的插件)
├── swap           # swap文件位置
├── .vimrc         # vim的配置文件
├── init.lua       # Neovim主入口：共享 Vimscript + Lua 专属配置
├── init.vim       # Neovim兼容入口
├── YBXUltiSnips   # 自定义的snippets片段
└── undodir        # 重新打开文件依旧可以撤销之前的编辑的缓存文件
```

## 安装说明

### Linux 安装

1. 克隆此仓库到 `~/.vim` 目录：
```bash
git clone <repository-url> ~/.vim
```

2. 创建软链接：
```bash
# For Vim
ln -s ~/.vim/.vimrc ~/.vimrc

# For Neovim
mkdir -p ~/.config/nvim
ln -s ~/.vim/init.lua ~/.config/nvim/init.lua
```

3. 安装依赖：
```bash
# Ubuntu/Debian
sudo apt-get install nodejs npm ctags cscope

# Arch Linux
sudo pacman -S nodejs npm ctags cscope
```

4. 打开 Vim/Neovim 后执行 `:PlugInstall` 安装插件；首次打开不会自动下载全部插件。

### macOS 安装

1. 克隆此仓库到 `~/.vim` 目录：
```bash
git clone <repository-url> ~/.vim
```

2. 创建软链接：
```bash
# For Vim
ln -s ~/.vim/.vimrc ~/.vimrc

# For Neovim
mkdir -p ~/.config/nvim
ln -s ~/.vim/init.lua ~/.config/nvim/init.lua
```

3. 安装依赖（使用 Homebrew）：
```bash
# 安装 Homebrew (如果还没有安装)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 安装必要的依赖
brew install node
brew install ctags
brew install cscope

# 可选：安装 Neovim
brew install neovim
```

4. 打开 Vim/Neovim 后执行 `:PlugInstall` 安装插件；首次打开不会自动下载全部插件。

## 平台特定功能

### macOS 特性
- **剪贴板集成**：自动使用系统剪贴板 (`clipboard=unnamed`)
- **HTML 预览**：使用 `open` 命令打开默认浏览器
- **编译运行**：支持 C/C++/Python 等语言的���译和运行

### Linux 特性
- **剪贴板集成**：使用 X11 剪贴板 (`clipboard=unnamedplus`)
- **HTML 预览**：使用 Firefox 浏览器
- **CUDA 支持**：支持 CUDA 程序的编译和运行

## 常见问题

### macOS 相关

1. **剪贴板不工作**
   - 确保 Vim 编译时启用了剪贴板支持
   - 检查：`vim --version | grep clipboard`
   - 如果显示 `-clipboard`，需要重新安装支持剪贴板的版本：
     ```bash
     brew install vim
     # 或者
     brew install macvim
     ```

2. **ctags 版本问题**
   - macOS 自带的 ctags 是 BSD 版本，功能有限
   - 建议安装 Universal Ctags：
     ```bash
     brew install --HEAD universal-ctags/universal-ctags/universal-ctags
     ```

3. **Node.js 相关插件问题**
   - 确保 Node.js 和 npm 已正确安装：
     ```bash
     node --version
     npm --version
     ```

### 通用问题

1. **插件安装失败**
   - 在 Vim 中运行 `:PlugInstall` 手动安装插件
   - 检查网络连接，必要时使用代理

2. **CoC 插件问题**
   - 建议使用 Node.js 20/22 LTS，至少确保 >= 14.14
   - GitHub 插件使用 SSH，确认 `ssh -T git@github.com` 可认证
   - npm 安装超时时在 `~/.npmrc` 配置 `registry=https://registry.npmmirror.com/` 和 `coc.nvim:registry=https://registry.npmmirror.com/`
   - 运行 `:checkhealth` (Neovim) 检查健康状态

## 快捷键说明

配置已经包含了跨平台的快捷键映射，在 macOS 和 Linux 上使用相同的快捷键。

完整文档：

- `~/.vim/doc/keymaps.md` - 全部快捷键、插件快捷键与冲突说明
- `~/.vim/doc/commands.md` - Vim 与插件命令速查
- `~/.vim/doc/plugins.md` - 插件功能、依赖与安装方式
- `~/.vim/doc/coc.md` - COC 配置、clangd/ccls 与 ctags 说明
- `~/.vim/doc/directories.md` - 目录与文件逐项说明

配置源码：

- `~/.vim/configs/vim/shortcut-key.vim` - 全局快捷键
- `~/.vim/configs/vim/compile-run.vim` - 编译运行快捷键
- `~/.vim/configs/neovim/` - Neovim Lua 配置
- `~/.vim/plugin/` - 各插件的快捷键配置

环境检查：

```bash
~/.vim/script/check-env.sh
~/.vim/script/check-env.sh --network
```


