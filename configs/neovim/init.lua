-- YBX Neovim configuration entry
-- 公共行为复用 configs/vim，Neovim 专属插件与配置集中在本目录 Lua 文件中。

local home = vim.fn.expand('~')
local vim_root = home .. '/.vim'
local vim_config = vim_root .. '/configs/vim'
local nvim_config = vim_root .. '/configs/neovim'

vim.opt.runtimepath:prepend(vim_root)
vim.opt.runtimepath:prepend(nvim_config)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- COC 配置与数据目录
vim.g.coc_config_home = vim_root
vim.g.coc_data_home = vim_root .. '/plugged/coc'

-- 优先使用用户目录中的 Node；没有时回退到系统 node/npm
local node_bin = home .. '/.local/opt/node/bin'
if vim.fn.executable(node_bin .. '/node') == 1 then
  vim.g.coc_node_path = node_bin .. '/node'
  vim.env.PATH = node_bin .. ':' .. (vim.env.PATH or '')
end

-- Neovim Python provider：优先使用专用虚拟环境，否则使用系统 Python
local nvim_python = home .. '/.venv/nvim-python/bin/python3'
vim.g.python3_host_prog = (vim.fn.executable(nvim_python) == 1) and nvim_python or vim.fn.exepath('python3')

local function source(name)
  vim.cmd('source ' .. vim.fn.fnameescape(vim_config .. '/' .. name))
end

-- 与 Vim 保持相同加载顺序
for _, name in ipairs({
  'shortcut-key.vim',
  'surface.vim',
  'file-setup.vim',
  'split-screen.vim',
  'customize.vim',
  'my-function.vim',
  'terminal-emulator.vim',
}) do
  source(name)
end

-- Neovim 专属插件声明
dofile(nvim_config .. '/plugins.lua')

for _, name in ipairs({
  'programming-environment.vim',
  'compile-run.vim',
  'debug.vim',
}) do
  source(name)
end

-- Neovim 终端快捷键
vim.keymap.set('n', '<Leader>t', ':split term://bash<CR>', { silent = true, desc = 'Open terminal' })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Terminal normal mode' })
vim.keymap.set('t', '<C-v><Esc>', '<Esc>', { desc = 'Send Escape to terminal' })
vim.opt.mouse = ''

-- Neovim 专属：presenting.nvim 与 treesitter
dofile(nvim_config .. '/presenting.lua')
