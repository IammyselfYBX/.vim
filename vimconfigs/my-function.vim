function! ClearSwapdir()
    " 定义 swap 文件目录
    let swapdir = expand('~/.vim/swap')

    " 确保目录存在
    if !isdirectory(swapdir)
        echo "Swap directory does not exist."
        return
    endif

    " 获取目录下所有 swap 文件
    let swapfiles = glob(swapdir . '/*', 0, 1)
    if empty(swapfiles)
        echo "No swap files found."
        return
    endif

    " 构建菜单项
    echo "Select the swap file to delete:"
    let i = 1
    for file in swapfiles
        echo i . '. ' . file
        let i += 1
    endfor
    echo "a. Delete all"
    echo "q. Quit"

    " 获取用户输入
    let choice = getcharstr()

    " 处理用户输入
    if choice == 'q'
        echo "Operation cancelled."
        return
    elseif choice == 'a'
        for file in swapfiles
            call delete(file)
        endfor
        echo "All swap files deleted."
    else
        let fileIndex = str2nr(choice) - 1
        if fileIndex >= 0 && fileIndex < len(swapfiles)
            call delete(swapfiles[fileIndex])
            echo "Deleted: " . swapfiles[fileIndex]
        else
            echo "Invalid option."
        endif
    endif
endfunction

" 将函数映射到命令
command! ClearSwapdir call ClearSwapdir()