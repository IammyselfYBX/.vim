"noremap m :MarkdownPreview<CR>
"nmap <silent> <C-F8> <Plug>StopMarkdownPreview
" 其实后面autocmd 配置之后直接<C-i>就可以了.
let g:mkdp_auto_start = 0   " 设置成1是在打开 markdown 文件的时候自动打开浏览器预览
let g:mkdp_auto_close = 1   " 在切换 buffer 的时候自动关闭预览窗口，设置为 0 则在切换 buffer 的时候不自动关闭预览窗口
let g:mkdp_refresh_slow = 0 " 设置为 1 则只有在保存文件，或退出插入模式的时候更新预览，默认为 0，实时更新预览
let g:mkdp_command_for_global = 0 " 设置为 1 则所有文件都可以使用 MarkdownPreview 进行预览，默认只有 markdown文件可以使用改命令
let g:mkdp_open_to_the_world = 0  " 设置为 1, 在使用的网络中的其他计算机也能访问预览页面,默认只监听本地（127.0.0.1），其他计算机不能访问
let g:mkdp_open_ip = ''
let g:mkdp_browser = 'wslview'
"function OpenMarkdownPreview (url)
"  execute "silent ! chromium --new-window " . a:url
"endfunction
"let g:mkdp_browserfunc = 'OpenMarkdownPreview'
"let g:mkdp_browser = '/bin/firefox'
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
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
" disable_sync_scroll: 设置为 1 禁用同步滚动。
" sync_scroll_type: 设置同步滚动的类型，这里是 'middle'。
" hide_yaml_meta: 设置为 1 时，隐藏 YAML 元数据。
" content_editable: 设置为 v:false，预览中的内容不可编辑。

let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_page_title = '「${name}」'
