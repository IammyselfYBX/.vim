"=========================Undotree
"https://github.com/mbbill/undotree
nnoremap L :UndotreeToggle<CR>
if has("persistent_undo")
    set undodir=$HOME/.vim/undodir
    set undofile
endif
