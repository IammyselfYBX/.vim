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

# 目录结构
```
.
├── autoload       # [自带]vim自启动的脚本
│   └── plug.vim   # vim-plug插件(考虑到外网下载速度，就已经自带安装到autoload文件夹中)
├── colors         # 颜色主题
├── pack           # 自定义的插件
│   ├── UtilityPlugin  # 实用工具
│   │    ├── start # vim开机自启动的插件
│   │    └── opt   # 手动:packadd加载插件
│   │        └── iciba-translate # 金山翻译
│   │            ├── plugin # 金山翻译插件代码
│   │            └── syntax # 语法突出显示的 Vim 脚本
│   └── WebDev      # Web开发工具
│       ├── start   # vim开机自启动的插件
│       └── opt     # 手动:packadd加载插件
│           └── vim-live-server # 实时预览
│               └── plugin # 实时预览插件代码
├── plugged        # vim-plug 安装的插件(与github同步，不会同步)
├── plugin         # [自带]vim自启动时加载的插件(这里存放如何设置vim-plug安装的插件)
├── swap           # swap文件位置
├── .vimrc         # vim的配置文件
├── init.vim       # neovim的配置文件
├── vimconfigs     # vimrc的模块化配置文件
│   ├── file-setup.vim        # 文件相关的设置
│   ├── shortcut-key.vim      # 自定义快捷键
│   ├── split-screen.vim      # 分屏相关的设置
│   ├── surface.vim           # 外观相关的设置
│   ├── customize.vim         # 其余不能归类的个性化设置
│   ├── plugins.vim           # 插件管理
│   ├── terminal-emulator.vim # 终端模拟器的配置
│   ├── compile-run.vim       # 编程的编译与执行相关的配置
│   └── debug.vim             # 编程调试的配置
├── YBXUltiSnips   # 自定义的snippets片段
└── undodir        # 重新打开文件依旧可以撤销之前的编辑的缓存文件
```


