" YBX Vim configuration entry
" 通用行为与插件声明统一使用 configs/vim/*.vim
" Neovim 在 init.vim 中先加载本文件，再加载 configs/neovim/*.lua

" 自定义快捷键
source ~/.vim/configs/vim/shortcut-key.vim

" 显示设置
source ~/.vim/configs/vim/surface.vim

" 文件设置
source ~/.vim/configs/vim/file-setup.vim

" 分屏
source ~/.vim/configs/vim/split-screen.vim

" 其余不能归类的个性化设置
source ~/.vim/configs/vim/customize.vim
source ~/.vim/configs/vim/my-function.vim

" 模拟终端
source ~/.vim/configs/vim/terminal-emulator.vim

" 插件管理
source ~/.vim/configs/vim/plugins.vim

" 编程环境
source ~/.vim/configs/vim/programming-environment.vim

" 程序编译与运行
source ~/.vim/configs/vim/compile-run.vim

" 程序调试
source ~/.vim/configs/vim/debug.vim
