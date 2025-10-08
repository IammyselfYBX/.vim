"======================================
" 快捷方式
" 在 ~/.vim/vimconfigs/compile-run.vim 中配置

"======================================
" 基础行为控制
let g:mkdp_auto_start = 0   " 设置成1是在打开 markdown 文件的时候自动打开浏览器预览
let g:mkdp_auto_close = 1   " 在切换 buffer 的时候自动关闭预览窗口，设置为 0 则在切换 buffer 的时候不自动关闭预览窗口
let g:mkdp_refresh_slow = 0 " 设置为 1 则只有在保存文件，或退出插入模式的时候更新预览，默认为 0，实时更新预览
let g:mkdp_command_for_global = 0 " 设置为 1 则所有文件都可以使用 MarkdownPreview 进行预览，默认只有 markdown文件可以使用改命令

"======================================
" 网络与访问配置
let g:mkdp_open_to_the_world = 0  
" 设置为 1, 在使用的网络中的其他计算机也能访问预览页面
" 默认为0, 只监听本地（127.0.0.1），其他计算机不能访问
let g:mkdp_open_ip = ''
" 设置预览服务器监听的IP地址，默认空字符串表示监听所有地址
" 如果 g:mkdp_open_to_the_world 设置为 0，则该选项无效

"======================================
" 浏览器设置
let g:mkdp_browser = ''
" 设置为空，使用自定义函数OpenMarkdownPreview根据系统环境选择浏览器
let g:mkdp_echo_preview_url = 1
" 设置为 1 则在命令行中显示预览页面的 URL，用于调试
" 默认为 0 不显示
" 跨平台浏览器打开函数
function! OpenMarkdownPreview(url)
  " 检测操作系统环境并选择对应的浏览器打开方式
  if has('wsl')
    " WSL环境：使用wslview调用Windows默认浏览器
    execute "silent ! wslview " . shellescape(a:url)
  elseif has('unix')
    if has('mac')
      " macOS环境：使用系统默认的Chrome浏览器
      execute "silent ! open -a 'Google Chrome' " . shellescape(a:url)
    else
      " Linux环境：使用chromium浏览器
      execute "silent ! chromium --new-window " . shellescape(a:url)
    endif
  elseif has('win32') || has('win64')
    " Windows环境：使用默认浏览器
    execute "silent ! start " . shellescape(a:url)
  else
    " 其他环境：尝试使用xdg-open（通用Linux方法）
    execute "silent ! xdg-open " . shellescape(a:url)
  endif
endfunction

let g:mkdp_browserfunc = 'OpenMarkdownPreview'
" 设置为自定义函数名，使用wslview在Windows浏览器中打开

"======================================
" 预览窗口设置
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false
    \ }
" 功能扩展
"  - mkit: 设置传递给 markdown-it 的选项，这里是一个空字典。
"  - katex: 设置传递给 KaTeX 的选项，这里是一个空字典。
"  - uml: 设置传递给 PlantUML 的选项，这里是一个空字典。
"  - maid: 设置传递给 Mermaid 的选项，这里是一个空字典。
" 滚动同步
"  - disable_sync_scroll: 设置为 1 禁用同步滚动。
"  - sync_scroll_type: 设置同步滚动的类型，这里是 'middle'。
" 显示控制
"  - hide_yaml_meta: 设置为 1 时，隐藏 YAML 元数据。
"  - content_editable: 设置为 v:false，预览中的内容不可编辑。

"======================================
" 样式与标题设置
let g:mkdp_markdown_css = ''
" 自定义 Markdown CSS 样式（当前为空，使用默认）
let g:mkdp_highlight_css = ''
" 自定义代码高亮 CSS 样式（当前为空，使用默认）"
let g:mkdp_page_title = '「${name}」'
" 设置预览页面的标题，${name} 会被替换为当前文件名
