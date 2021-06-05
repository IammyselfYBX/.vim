"https://github.com/xuhdev/vim-latex-live-preview
au BufRead,BufNewFile *.tex set filetype=tex "有时虽然是.tex文件结尾但是依旧不识别时tex文件
let g:livepreview_previewer = 'zathura'
let g:livepreview_engine = '/usr/local/texlive/2018/bin/x86_64-linux/xelatex'
"let g:livepreview_engine = '/usr/local/texlive/2018/bin/x86_64-linux/pdflatex'
"let g:livepreview_engine = '/usr/local/texlive/2018/bin/x86_64-linux/latexmk -xelatex -f'
 " 判断是否是 tex 类型,加载插件
let g:livepreview_cursorhold_recompile = 0
autocmd Filetype tex setl updatetime=1  "PDF文件刷新频率,官方推荐值为“1”，单位应是“秒”
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
