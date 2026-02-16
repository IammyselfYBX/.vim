"======================================
" FZF + Ripgrep 插件配置
"======================================
" 项目地址:
"   https://github.com/junegunn/fzf.vim
"   https://github.com/junegunn/fzf
"======================================

"======================================
" 基础快捷键
"======================================
nnoremap <C-f> :FZF<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <Leader>h :History<CR>

"======================================
" 方法 1: 使用 FZF + Ripgrep 进行项目内容搜索（推荐）
"======================================
" 需要先安装 ripgrep 或 ag:
"   Ubuntu/Debian: sudo apt install ripgrep
"   Arch Linux:    sudo pacman -S ripgrep
"   macOS:         brew install ripgrep
"
" 使用方法:
"   :Rg <搜索内容>        " 使用 ripgrep 搜索项目内容（推荐）
"   :Ag <搜索内容>        " 使用 ag 搜索项目内容
"
" 示例:
"   :Rg TODO              " 搜索所有包含 TODO 的文件
"   :Rg function_name     " 搜索函数名
"   :Rg old_name          " 搜索要替换的内容
"   :Rg pattern -t py     " 只搜索 .py 文件（-t 指定文件类型）
"   :Rg pattern -g '*.js' " 只搜索 .js 文件（-g 指定 glob 模式）
"
" 搜索结果会显示在 Quickfix 窗口中，可以:
"   - 回车跳转到对应位置
"   - <F10> 打开/关闭 Quickfix 窗口（在 asyncrun.vim 中配置）
"   - :copen 打开 Quickfix 窗口
"   - :cclose 关闭 Quickfix 窗口
"======================================

"======================================
" 方法 2: 项目级批量替换（结合 cfdo）
"======================================
" 完整替换流程:
"
" 步骤 1: 使用 Rg 搜索要替换的内容
"   :Rg old_name
"
" 步骤 2: 在 Quickfix 窗口中预览搜索结果
"   <F10>                 " 打开 Quickfix 窗口查看结果
"
" 步骤 3: 使用 cfdo 批量替换（逐个确认）
"   :cfdo %s/old_name/new_name/gc | update
"
" 或者不需要确认直接替换:
"   :cfdo %s/old_name/new_name/g | update
"
" 参数说明:
"   - cfdo              对 Quickfix 列表中的每个文件执行命令
"   - %s/old/new/g      全局替换（g=global，替换所有匹配）
"   - %s/old/new/gc     逐个确认替换（c=confirm，每次替换前确认）
"   - | update          保存修改过的文件
"
" 实战示例:
"   " 将项目中所有 old_api 替换为 new_api
"   :Rg old_api
"   :cfdo %s/old_api/new_api/gc | update
"
"   " 只替换 Python 文件中的内容
"   :Rg old_name -t py
"   :cfdo %s/old_name/new_name/g | update
"======================================

"======================================
" 方法 3: Vim 原生 vimgrep 搜索
"======================================
" 使用方法:
"   :vimgrep /pattern/ **/*.py    " 搜索所有 .py 文件
"   :vimgrep /pattern/ **/*       " 搜索所有文件
"   :copen                        " 打开 Quickfix 窗口
"   :cfdo %s/old/new/g | update   " 批量替换
"
" 注意: vimgrep 比 Rg 慢，大型项目推荐使用 Rg
"======================================

"======================================
" 高级技巧
"======================================
" 1. 搜索光标下的单词:
"   将光标移动到要搜索的单词上，然后:
"   :Rg <C-r><C-w>            " Ctrl+r Ctrl+w 会插入光标下的单词
"
" 2. 搜索可视化选中的文本:
"   先用 v 模式选中文本，按 y 复制，然后:
"   :Rg <C-r>"                " Ctrl+r " 会插入复制的内容
"
" 3. 正则表达式搜索:
"   :Rg 'func.*\('            " 搜索以 func 开头后面跟 ( 的内容
"   :Rg '\bword\b'            " 精确匹配单词边界
"
" 4. 排除某些目录:
"   :Rg pattern -g '!node_modules/*'  " 排除 node_modules 目录
"   :Rg pattern -g '!*.test.js'       " 排除测试文件
"======================================

"======================================
" FZF 预览窗口配置
"======================================
" This is the default option:
"   - Preview window on the right with 50% width
"   - CTRL-/ will toggle preview window.
" - Note that this array is passed as arguments to fzf#vim#with_preview function.
" - To learn more about preview window options, see `--preview-window` section of `man fzf`.
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" Preview window on the upper side of the window with 40% height,
" hidden by default, ctrl-/ to toggle
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']

" Empty value to disable preview window altogether
let g:fzf_preview_window = []
