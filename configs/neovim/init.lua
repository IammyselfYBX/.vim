-- Neovim 专属 Lua 配置。
-- 通用配置和插件声明统一由 configs/vim/*.vim 提供，避免重复维护。

local nvim_config = vim.fn.expand('~/.vim/configs/neovim')

dofile(nvim_config .. '/presenting.lua')
