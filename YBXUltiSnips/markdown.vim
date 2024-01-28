"这里设置 Markdown 的snippets
" autocmd Filetype markdown inoremap ,f <ESC>/<++><CR>:nohlsearch<CR>c4l
" autocmd Filetype markdown inoremap ,n ---<Enter><Enter>
" autocmd Filetype markdown inoremap ,b **** <++><ESC>F*hi
" autocmd Filetype markdown inoremap ,s ~~~~ <++><ESC>F~hi
" autocmd Filetype markdown inoremap ,i ** <++><ESC>F*i
" autocmd Filetype markdown inoremap ,c ```<Enter><Enter>```<Enter><++><ESC>3kA
" autocmd Filetype markdown inoremap ,p ![](<++>) <++><ESC>F[a
" autocmd Filetype markdown inoremap ,a [](<++>) <++><ESC>F[a
" autocmd Filetype markdown inoremap ,1 #<Space><Enter><++><ESC>kA
" autocmd Filetype markdown inoremap ,2 ##<Space><Enter><++><ESC>kA
" autocmd Filetype markdown inoremap ,3 ###<Space><Enter><++><ESC>kA
" autocmd Filetype markdown inoremap ,4 ####<Space><Enter><++><ESC>kA
" autocmd Filetype markdown inoremap ,5 #####<Space><Enter><++><ESC>kA
" autocmd Filetype markdown inoremap ,6 ######<Space><Enter><++><ESC>kA
inoremap ,f <ESC>/<++><CR>:nohlsearch<CR>c4l
inoremap ,n ---<Enter>
inoremap ,b **** <++><ESC>F*hi
inoremap ,s ~~~~ <++><ESC>F~hi
inoremap ,i ** <++><ESC>F*i
inoremap ,c ```<Enter><++><Enter>```<Enter><++><ESC>3kA
inoremap ,p ![](<++>) <++><ESC>F[a
inoremap ,a [](<++>) <++><ESC>F[a
inoremap ,1 #<Space><Enter><++><ESC>kA
inoremap ,2 ##<Space><Enter><++><ESC>kA
inoremap ,3 ###<Space><Enter><++><ESC>kA
inoremap ,4 ####<Space><Enter><++><ESC>kA
inoremap ,5 #####<Space><Enter><++><ESC>kA
inoremap ,6 ######<Space><Enter><++><ESC>kA


" 配合 vim-table-mode 画表格
" autocmd Filetype markdown inoremap <  <++>\|
inoremap \|<  \| <++> 
"inoremap <silent> ]\














