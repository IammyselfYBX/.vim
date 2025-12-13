" 设置PDF预览器为zathura
let g:livepreview_previewer = 'zathura'

"===========================================
" LaTeX引擎
" 自动检测并设置LaTeX引擎路径
" 仅在 tex 文件时检测并设置 LaTeX 引擎
augroup latex_engine_detect
    autocmd!
    autocmd BufRead,BufNewFile *.tex call s:CheckLatexEngine()
augroup END

function! s:CheckLatexEngine()
    if executable('xelatex')
        let g:livepreview_engine = substitute(system('which xelatex'), '\n\+$', '', '')
        echo "LaTeX引擎已自动设置为: " . g:livepreview_engine
    else
        let g:livepreview_engine = '/usr/local/texlive/2018/bin/x86_64-linux/xelatex'
        echo "警告: 未找到xelatex，使用默认路径: " . g:livepreview_engine
    endif
endfunction

" 手动设置LaTeX引擎路径
" let g:livepreview_engine = '/usr/local/texlive/2018/bin/x86_64-linux/xelatex'
"let g:livepreview_engine = '/usr/local/texlive/2018/bin/x86_64-linux/pdflatex'
"let g:livepreview_engine = '/usr/local/texlive/2018/bin/x86_64-linux/latexmk -xelatex -f'

" 禁用光标停留时自动重新编译（避免频繁编译影响性能）"
let g:livepreview_cursorhold_recompile = 0

" 仅对tex文件类型设置PDF文件刷新频率为1秒
" 官方推荐值为“1”，单位应是“秒”
autocmd Filetype tex setl updatetime=1
"nmap <F12> :LLPStartPreview<cr>

" 这个插件在与UltiSnips一起作为插件安装时，它完全破坏了<C-j>和<C-k>的映射，这里进行修改冲突(其实最坑的是就是不是tex文件这个映射依旧被修改了)
if &filetype != 'tex'
  "imap <m-C-J> <Plug>IMAP_JumpForward
  "nmap <m-C-J> <Plug>IMAP_JumpForward
  "vmap <m-C-J> <Plug>IMAP_JumpForward
  "vmap <m-C-J> <Plug>IMAP_DeleteAndJumpForward
  imap <Leader>#$ <Plug>IMAP_JumpForward
  nmap <Leader>#$ <Plug>IMAP_JumpForward
  vmap <Leader>#$ <Plug>IMAP_JumpForward
  vmap <Leader>#$ <Plug>IMAP_DeleteAndJumpForward
endif
