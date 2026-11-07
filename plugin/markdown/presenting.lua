-- presenting.nvim配置文件
--使用 VimEnter 事件延迟执行，确保 vim-plug 已完成所有路径注入
vim.api.nvim_create_autocmd('VimEnter', {
    once = true,
    callback = function()
        -- 1. 启用 Treesitter 高亮（必须在 presenting 之前或同时加载）
        -- 手动将 nvim-treesitter 加入 runtimepath
        local ts_path = vim.fn.expand('~/.vim/plugged/nvim-treesitter')
        if vim.fn.isdirectory(ts_path) == 1 then
            vim.opt.runtimepath:prepend(ts_path)
        end

        -- 1. 启用 Treesitter 高亮
        local ts_ok, ts_configs = pcall(require, 'nvim-treesitter.configs')
        if ts_ok then
            ts_configs.setup({
                highlight = {
                    enable = true,       -- 核心：开启 TS 高亮以隐藏 ** 和 `
                    disable = {},        -- 不禁用任何语言
                },
            })
        else
            vim.notify('[presenting] nvim-treesitter not found!', vim.log.levels.WARN)
        end

        -- 2. 加载并配置 presenting.nvim
        local ok, presenting = pcall(require, 'presenting')
        if not ok then
            vim.notify('[presenting] load failed: ' .. tostring(presenting), vim.   log.levels.ERROR)
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

        -- 3. 注册命令
        if vim.fn.exists(':Presenting') == 0 then
            vim.api.nvim_create_user_command('Presenting', function()
                require('presenting').toggle()
            end, { desc = 'Toggle Presenting Mode' })
        end
    end,
})
