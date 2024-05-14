"=========================Undotree
"https://github.com/mbbill/undotree
nnoremap <F5> :UndotreeToggle<CR>
if has("persistent_undo")
    set undodir=$HOME/.vim/undodir
    set undofile
endif
