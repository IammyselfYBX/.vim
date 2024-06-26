" 运行程序前编译的命令&执行
"-----------------------------------------------------------------------------
" Vim的autocmd FileType 判断语言类型，<C-c>来进行编译 <C-i>运行
"-----------------------------------------------------------------------------

if g:is_linux
    
    " C Compiler:
    "autocmd FileType c nnoremap <buffer> <C-c> :!gcc % -o %< && ./%< <CR>
    autocmd FileType c nnoremap <buffer> <C-c> :AsyncRun gcc -Wall % -o %< <CR>
    "autocmd FileType c nnoremap <buffer> <C-r> :! ./%< <CR>
    "autocmd FileType c nnoremap <buffer> <C-r> :AsyncRun ./%< <CR>
    autocmd FileType c nnoremap <buffer> <C-r> :call RunExecutable()<CR>
    autocmd FileType c nnoremap <buffer> <C-p> :call CompileProject()<CR>
    
    
    " C++ Compiler
    au BufRead,BufNewFile *.h set filetype=cpp "有时.h文件默认时C的,引入C++的头文件ALE会报错
    "autocmd FileType cpp nnoremap <buffer> <C-i> :!g++ % -o %< && ./%:r <CR>
    autocmd FileType cpp nnoremap <buffer> <C-c> :AsyncRun g++ % -o %< <CR>
    "autocmd FileType cpp nnoremap <buffer> <C-r> :AsyncRun ./%:r <CR>
    autocmd FileType cpp nnoremap <buffer> <C-r> :call RunExecutable()<CR>
    autocmd FileType cpp nnoremap <buffer> <C-p> :call CompileProject()<CR>
    " 自动命令：当文件类型为 cuda 时，映射 Ctrl+c 键来编译 CUDA 程序
    autocmd FileType cuda nnoremap <buffer> <C-c> :call CompileCuda()<CR>
    autocmd FileType cuda nnoremap <buffer> <C-r> :call RunExecutable()<CR>
    
    " Python Interpreter
    " autocmd FileType python nnoremap <buffer> <C-i> :!python % <CR>
    " autocmd FileType python nnoremap <buffer> <C-r> :AsyncRun python3 % <CR>
    autocmd FileType python nnoremap <buffer> <C-r> :call RunPython()<CR>

elseif g:is_mac
    " C Compiler:
    "autocmd FileType c nnoremap <buffer> <C-c> :!gcc % -o %< && ./%< <CR>
    autocmd FileType c nnoremap <buffer> <C-c> :AsyncRun gcc -Wall % -o %< <CR>
    "autocmd FileType c nnoremap <buffer> <C-r> :! ./%< <CR>
    "autocmd FileType c nnoremap <buffer> <C-r> :AsyncRun ./%< <CR>
    autocmd FileType c nnoremap <buffer> <C-r> :call RunExecutable()<CR>
    autocmd FileType c nnoremap <buffer> <C-p> :call CompileProject()<CR>
    
    
    " C++ Compiler
    au BufRead,BufNewFile *.h set filetype=cpp "有时.h文件默认时C的,引入C++的头文件ALE会报错
    "autocmd FileType cpp nnoremap <buffer> <C-i> :!g++ % -o %< && ./%:r <CR>
    autocmd FileType cpp nnoremap <buffer> <C-c> :AsyncRun g++ % -o %< <CR>
    "autocmd FileType cpp nnoremap <buffer> <C-r> :AsyncRun ./%:r <CR>
    autocmd FileType cpp nnoremap <buffer> <C-r> :call RunExecutable()<CR>
    autocmd FileType cpp nnoremap <buffer> <C-p> :call CompileProject()<CR>
    
    " Python Interpreter
    " autocmd FileType python nnoremap <buffer> <C-i> :!python % <CR>
    " autocmd FileType python nnoremap <buffer> <C-r> :AsyncRun python3 % <CR>
    autocmd FileType python nnoremap <buffer> <C-r> :call RunPython()<CR>
endif    

" Bash script
" autocmd FileType sh nnoremap <buffer> <C-i> :!sh % <CR>
autocmd FileType sh nnoremap <buffer> <C-r> :AsyncRun sh % <CR>

" Executable
" nnoremap <buffer> <C-i> :!./% <CR>
nnoremap <buffer> <C-r> :AsyncRun ./% <CR>

" RCs (Configs)
autocmd FileType vim,zsh,tmux nnoremap <buffer> <C-r> :source % <CR>

        " Java
        "autocmd Filetype java nnoremap <buffer> <C-i> :!javac % && java %:r <CR>
        autocmd Filetype java nnoremap <buffer> <C-c> :AsyncRun javac % <CR>
        "autocmd Filetype java nnoremap <buffer> <C-i> :! java %:r <CR>
autocmd Filetype java nnoremap <buffer> <C-r> :AsyncRun java %:r <CR>

" HTML
autocmd Filetype html nnoremap <buffer> <C-i> :!firefox % &<CR>

" Markdown 前提是已经安装MarkdownPreview插件
autocmd Filetype markdown nnoremap <buffer> <C-r> :MarkdownPreview <CR>
"autocmd Filetype markdown source ~/.vim/UltiSnips/markdown.vim

" Latex 
"autocmd Filetype tex nnoremap <buffer> <C-c> :AsyncRun latexmk <cr>
"autocmd Filetype tex nnoremap <buffer> <C-r> :LLPStartPreview<cr>
autocmd FileType tex nnoremap <buffer> <C-c> :AsyncLatex <CR>




" 项目编译函数
"" 查找包含指定标识文件或目录的最顶层父目录
function! FindRootDir(marker)
    let l:current_dir = expand('%:p:h')
    while l:current_dir != '/' && !filereadable(l:current_dir . '/' . a:marker) && !isdirectory(l:current_dir . '/' . a:marker)
        let l:current_dir = fnamemodify(l:current_dir, ':h')
    endwhile
    return l:current_dir
endfunction

"" 在项目根目录执行 LaTeX 编译命令
autocmd FileType tex command! AsyncLatex call AsyncRunLatex()
function! AsyncRunLatex()
    let root_dir = FindRootDir('main.tex')
    if root_dir != '/'
        execute 'AsyncRun -cwd=' . root_dir . ' latexmk -f main.tex'
    else
        echo "Latex项目根目录必须有main.tex文件"
    endif
endfunction
 
"" 在项目根目录执行编译命令
function! CompileProject()
    let root_dir_make = FindRootDir('Makefile')
    let root_dir_cmake = FindRootDir('CMakeLists.txt')

    if root_dir_make != '/' && filereadable(root_dir_make . '/Makefile')
        execute 'AsyncRun -cwd=' . root_dir_make . ' make'
    elseif root_dir_cmake != '/' && filereadable(root_dir_cmake . '/CMakeLists.txt')
        let build_dir = root_dir_cmake . '/build'
        if !isdirectory(build_dir)
            call mkdir(build_dir)
        endif
        execute 'AsyncRun -cwd=' . build_dir . ' cmake .. && make'
    else
        echo "No Makefile or CMakeLists.txt found in any parent directory."
    endif
endfunction

"运行可执行文件
" 根据文件名判断可执行文件
"function! RunExecutable()
"    let file_name = expand('%:t:r')  " 获取当前文件的基本名（不含扩展名）
"    let root_dir_make = FindRootDir('Makefile')
"    let root_dir_cmake = FindRootDir('CMakeLists.txt')
"
"    if root_dir_make != '/' && filereadable(root_dir_make . '/Makefile')
"        execute 'AsyncRun -cwd=' . root_dir_make . ' ./' . file_name
"    elseif root_dir_cmake != '/' && filereadable(root_dir_cmake . '/CMakeLists.txt')
"        let build_dir = root_dir_cmake . '/build'
"        execute 'AsyncRun -cwd=' . build_dir . ' ./' . file_name
"    else
"        execute 'AsyncRun ./%<'
"    endif
"endfunction

"" 根据文件属性判断可执行文件
"" 辅助 RunExecutable 函数，我们需要一个新的函数来在指定目录中找到第一个可执行文件：
function! FindExecutable(dir)
    let files = split(glob(a:dir . '/*'), '\n')
    for file in files
        if executable(file)
            return fnamemodify(file, ':t')
        endif
    endfor
    return ''
endfunction

" function! RunExecutable()
"     let root_dir_make = FindRootDir('Makefile')
"     let root_dir_cmake = FindRootDir('CMakeLists.txt')
" 
"     if root_dir_make != '/' && filereadable(root_dir_make . '/Makefile')
"         let executable_path = FindExecutable(root_dir_make)
"         if executable_path != ''
"             execute 'AsyncRun -cwd=' . root_dir_make . ' ./' . executable_path
"         endif
"     elseif root_dir_cmake != '/' && filereadable(root_dir_cmake . '/CMakeLists.txt')
"         let build_dir = root_dir_cmake . '/build'
"         let executable_path = FindExecutable(build_dir)
"         if executable_path != ''
"             execute 'AsyncRun -cwd=' . build_dir . ' ./' . executable_path
"         endif
"     else
"         let executable_path = FindExecutable(getcwd())
"         if executable_path != ''
"             execute 'AsyncRun ./' . executable_path
"         endif
"     endif
function! RunExecutable()
    " 获取当前文件名（不带扩展名）
    let current_file = expand('%:t:r')
    " 获取当前文件的路径
    let current_file_path = getcwd() . '/' . current_file

    " 如果与当前文件同名的可执行文件存在，直接执行它
    if filereadable(current_file_path) && !isdirectory(current_file_path)
        execute 'AsyncRun ./%<'
    else
        " 查找包含 'Makefile' 的根目录
        let root_dir_make = FindRootDir('Makefile')
        " 查找包含 'CMakeLists.txt' 的根目录
        let root_dir_cmake = FindRootDir('CMakeLists.txt')

        " 如果找到的根目录不是 '/' 并且根目录中存在 'Makefile' 文件
        if root_dir_make != '/' && filereadable(root_dir_make . '/Makefile')
            " 在根目录中找到可执行文件的路径
            let executable_path = FindExecutable(root_dir_make)
            " 如果找到可执行文件
            if executable_path != ''
                " 使用 AsyncRun 插件在根目录下异步运行可执行文件
                execute 'AsyncRun -cwd=' . root_dir_make . ' ./' . executable_path
            endif
        " 如果找到的根目录不是 '/' 并且根目录中存在 'CMakeLists.txt' 文件
        elseif root_dir_cmake != '/' && filereadable(root_dir_cmake . '/CMakeLists.txt')
            " 设置构建目录为根目录下的 'build' 文件夹
            let build_dir = root_dir_cmake . '/build'
            " 在构建目录中找到可执行文件的路径
            let executable_path = FindExecutable(build_dir)
            " 如果找到可执行文件
            if executable_path != ''
                " 使用 AsyncRun 插件在构建目录下异步运行可执行文件
                execute 'AsyncRun -cwd=' . build_dir . ' ./' . executable_path
            endif
        else
            " 在当前工作目录中找到第一个不是以 .o 结尾的可执行文件
            let executable_path = ''
            for file in split(glob('*'), '\n')
                if filereadable(file) && file !~ '\.o$' && !isdirectory(file)
                    let executable_path = file
                    break
                endif
            endfor

            " 如果找到可执行文件
            if executable_path != ''
                execute 'AsyncRun ./' . executable_path
            else
                echo "No executable file found."
            endif
        endif
    endif
endfunction

"" 编译 CUDA 程序的函数
function! CompileCuda()
    " 检查 nvcc 编译器是否存在
    if executable('nvcc')
        " 自动检测 GPU 架构
        let gpu_arch = DetectGpuArch()
        if gpu_arch == ''
            echo "无法检测到 GPU 架构，请手动设置。"
            return
        endif

        let compile_command = 'nvcc -arch=' . gpu_arch . ' % -o %<'
        " 异步运行编译命令
        execute 'AsyncRun ' . compile_command
    else
        " 如果 nvcc 不存在，提示用户安装 CUDA
        echo "nvcc 编译器未找到，请安装 CUDA 开发工具包。"
    endif
endfunction

"" 检测 GPU 架构的函数
""" 可以访问 https://www.nvidia.com/en-eu/geforce/graphics-cards/compare/
function! DetectGpuArch()
    " 检查 nvidia-smi 命令是否存在
    if !executable('nvidia-smi')
        echo "nvidia-smi 命令未找到，请安装 NVIDIA 驱动。"
        return ''
    endif

    " 获取 GPU 型号
    let l:output = system('nvidia-smi --query-gpu=name --format=csv,noheader')
    let l:gpu_name = substitute(l:output, '\n', '', 'g')

    " 根据 GPU 型号映射到对应的架构
    if l:gpu_name =~? 'GTX 1080\|GTX 1070\|GTX 1060\|Tesla P100'
        return 'sm_60'
    elseif l:gpu_name =~? 'RTX 2080\|RTX 2070\|RTX 2060\|Tesla T4'
        return 'sm_75'
    elseif l:gpu_name =~? 'RTX 3080\|RTX 3070\|RTX 3060\|A100'
        return 'sm_80'
    elseif l:gpu_name =~? 'RTX 3090'
        return 'sm_86'
    elseif l:gpu_name =~? 'RTX 4090'
        return 'sm_90'
    else
        return ''
    endif
endfunction


" endfunction

"" python的执行
""" 检查 Conda 是否安装并列出环境
function! CheckAndListCondaEnvs()
    if executable('conda')
        let g:has_conda = 1
        "let envs = system("conda env list | awk '{if(NR>2) print NR-2 \": \" $1}'")
        let envs = system("conda env list | grep -v '^\\s*$' | awk 'NR > 2 {print NR-2 \": \" $1}'") "去掉空行
        let g:conda_envs = split(envs, "\n")
    else
        let g:has_conda = 0
        echo "Conda is not installed. Consider installing it for better environment management."
    endif
endfunction

"" 用户选择 Conda 环境
function! SelectCondaEnv()
    if g:has_conda
        echo "Select a Conda environment by number:"
        let idx = inputlist(['Select a Conda environment:'] + g:conda_envs)
        if idx > 0 && idx <= len(g:conda_envs)
            let selected_env = split(g:conda_envs[idx - 1], ": ")[1]
            return 'conda run -n ' . selected_env . ' python3'
        else
            return 'python3'
        endif
    endif
    return 'python3'
endfunction

"" 运行 Python 脚本
function! RunPython()
    call CheckAndListCondaEnvs()
    let python_cmd = SelectCondaEnv()
    execute 'AsyncRun ' . python_cmd . ' %'
endfunction
