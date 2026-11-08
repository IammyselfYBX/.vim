# 插件目录约定

- `coc/`：coc.nvim 的数据目录，包括通过 `:CocInstall` 安装的扩展、MRU 和缓存。
- `vim-plug/`：由 vim-plug 管理的 Vim 插件。

这两个目录由插件管理器按需创建，不纳入 Git 版本控制。

如果聊天或命令中看到：

```text
g:coc_data_home = ~/.vim/plugged/coc
plug#begin('~/.vim/plugged/vim-plug')
```

就表示上述分工已经生效。
