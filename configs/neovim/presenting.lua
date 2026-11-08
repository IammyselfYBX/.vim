-- presenting.nvim + nvim-treesitter 配置
local function setup()
  local ts_path = vim.fn.expand('~/.vim/plugged/vim-plug/nvim-treesitter')
  if vim.fn.isdirectory(ts_path) == 1 then
    vim.opt.runtimepath:append(ts_path)
  end

  local ts_ok, ts_configs = pcall(require, 'nvim-treesitter.configs')
  if ts_ok then
    ts_configs.setup({
      highlight = {
        enable = true,
        disable = {},
      },
    })
  else
    vim.notify('[presenting] nvim-treesitter not found', vim.log.levels.WARN)
  end

  local ctx_ok, context = pcall(require, 'treesitter-context')
  if ctx_ok then
    context.setup({})
  end

  local presenting_ok, presenting = pcall(require, 'presenting')
  if not presenting_ok then
    vim.notify('[presenting] load failed: ' .. tostring(presenting), vim.log.levels.ERROR)
    return
  end

  if type(presenting.setup) == 'function' then
    pcall(presenting.setup)
  end

  if vim.fn.exists(':Presenting') == 0 then
    vim.api.nvim_create_user_command('Presenting', function()
      require('presenting').toggle()
    end, { desc = 'Toggle Presenting' })
  end
end

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = setup,
})
