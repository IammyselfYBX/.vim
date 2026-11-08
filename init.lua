-- Neovim 主入口：加载共享 Vimscript，再加载 Neovim 专属 Lua 配置
local vim_root = vim.fn.expand('~/.vim')

vim.opt.runtimepath:prepend(vim_root)
vim.cmd('source ' .. vim.fn.fnameescape(vim_root .. '/.vimrc'))
dofile(vim_root .. '/configs/neovim/init.lua')
