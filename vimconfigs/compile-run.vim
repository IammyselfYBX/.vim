" 编译、运行与项目构建
" 屏幕映射:
"   <C-c> 编译当前文件
"   <C-r> 运行当前文件或项目可执行文件
"   <C-p> 编译 Makefile / CMake 项目

augroup TonyCompileRun
  autocmd!
  autocmd BufRead,BufNewFile *.h setfiletype cpp
  autocmd FileType c,cpp,fortran,cuda nnoremap <buffer> <C-c> :call CompileSingleFile()<CR>
  autocmd FileType c,cpp,fortran,cuda nnoremap <buffer> <C-r> :call RunExecutable()<CR>
  autocmd FileType c,cpp nnoremap <buffer> <C-p> :call CompileProject()<CR>
  autocmd FileType python nnoremap <buffer> <C-r> :call RunPython()<CR>
  autocmd FileType java nnoremap <buffer> <C-c> :call CompileSingleFile()<CR>
  autocmd FileType java nnoremap <buffer> <C-r> :call RunJava()<CR>
  autocmd FileType sh nnoremap <buffer> <C-r> :call RunShell()<CR>
  autocmd FileType vim,zsh,tmux nnoremap <buffer> <C-r> :source %<CR>
  autocmd FileType html nnoremap <buffer> <C-i> :call OpenInBrowser()<CR>
  autocmd FileType markdown nnoremap <buffer> <C-r> :call RunMarkdownPreview()<CR>
  autocmd FileType tex nnoremap <buffer> <C-c> :AsyncLatex<CR>
  autocmd FileType tex nnoremap <buffer> <C-r> :call RunLatexPreview()<CR>
augroup END

command! AsyncLatex call AsyncRunLatex()

" 从当前文件所在目录向上查找指定文件或目录
function! FindRootDir(marker)
  let l:current_dir = expand('%:p:h')
  if empty(l:current_dir)
    let l:current_dir = getcwd()
  endif

  while 1
    if filereadable(l:current_dir . '/' . a:marker)
          \ || isdirectory(l:current_dir . '/' . a:marker)
      return l:current_dir
    endif

    let l:parent = fnamemodify(l:current_dir, ':h')
    if empty(l:parent) || l:parent ==# l:current_dir
      break
    endif
    let l:current_dir = l:parent
  endwhile
  return ''
endfunction

function! AsyncRunLatex()
  let l:root_dir = FindRootDir('main.tex')
  if empty(l:root_dir)
    echo '未找到包含 main.tex 的 LaTeX 项目根目录'
    return
  endif
  execute 'AsyncRun cd ' . shellescape(l:root_dir) . ' && latexmk -f main.tex'
endfunction

function! CompileProject()
  let l:make_root = FindRootDir('Makefile')
  let l:cmake_root = FindRootDir('CMakeLists.txt')

  if !empty(l:make_root) && filereadable(l:make_root . '/Makefile')
    execute 'AsyncRun cd ' . shellescape(l:make_root) . ' && make'
  elseif !empty(l:cmake_root) && filereadable(l:cmake_root . '/CMakeLists.txt')
    execute 'AsyncRun cd ' . shellescape(l:cmake_root)
          \ . ' && cmake -S . -B build && cmake --build build'
  else
    echo '未找到 Makefile 或 CMakeLists.txt'
  endif
endfunction

function! CompileSingleFile()
  let l:src = expand('%:p')
  if empty(l:src)
    echo '当前 buffer 没有文件路径'
    return
  endif

  if &filetype ==# 'cuda'
    call CompileCuda()
    return
  endif

  let l:exe = expand('%:p:r')
  if &filetype ==# 'c'
    if !executable('gcc')
      echo '未找到 gcc'
      return
    endif
    let l:cmd = 'gcc -Wall -g ' . shellescape(l:src) . ' -o ' . shellescape(l:exe) . ' -lm'
  elseif &filetype ==# 'cpp'
    if !executable('g++')
      echo '未找到 g++'
      return
    endif
    let l:cmd = 'g++ -Wall -g -std=c++17 ' . shellescape(l:src) . ' -o ' . shellescape(l:exe)
  elseif &filetype ==# 'fortran'
    if !executable('gfortran')
      echo '未找到 gfortran'
      return
    endif
    let l:cmd = 'gfortran -g ' . shellescape(l:src) . ' -o ' . shellescape(l:exe)
  elseif &filetype ==# 'java'
    if !executable('javac')
      echo '未找到 javac'
      return
    endif
    let l:cmd = 'javac -g ' . shellescape(l:src)
  else
    echo '当前文件类型不支持单文件编译: ' . &filetype
    return
  endif

  execute 'AsyncRun ' . l:cmd
endfunction

function! CollectExecutables(dir)
  if empty(a:dir) || !isdirectory(a:dir)
    return []
  endif

  let l:result = []
  for l:file in globpath(a:dir, '*', 0, 1)
    if !isdirectory(l:file) && executable(l:file)
          \ && l:file !~? '\.\(o\|obj\|a\|so\|dylib\|dll\)$'
      call add(l:result, l:file)
    endif
  endfor
  return l:result
endfunction

function! FindExecutable(dir, preferred)
  let l:files = CollectExecutables(a:dir)
  if empty(l:files)
    return ''
  endif

  for l:file in l:files
    if fnamemodify(l:file, ':t') ==# a:preferred
      return l:file
    endif
  endfor
  return l:files[0]
endfunction

function! RunExecutable()
  let l:source_dir = expand('%:p:h')
  let l:preferred = expand('%:t:r')
  let l:direct = l:source_dir . '/' . l:preferred

  if executable(l:direct)
    execute 'AsyncRun ' . shellescape(l:direct)
    return
  endif

  let l:make_root = FindRootDir('Makefile')
  let l:cmake_root = FindRootDir('CMakeLists.txt')

  if !empty(l:make_root) && filereadable(l:make_root . '/Makefile')
    let l:program = FindExecutable(l:make_root, l:preferred)
  elseif !empty(l:cmake_root) && filereadable(l:cmake_root . '/CMakeLists.txt')
    let l:build_dir = l:cmake_root . '/build'
    let l:program = FindExecutable(l:build_dir, l:preferred)
    if empty(l:program)
      let l:program = FindExecutable(l:build_dir . '/bin', l:preferred)
    endif
  else
    let l:program = FindExecutable(l:source_dir, l:preferred)
  endif

  if empty(l:program)
    echo '未找到可执行文件，请先编译'
    return
  endif

  execute 'AsyncRun ' . shellescape(l:program)
endfunction

function! CompileCuda()
  if !executable('nvcc')
    echo '未找到 nvcc，当前机器可能没有安装 CUDA'
    return
  endif

  let l:arch = DetectGpuArch()
  if empty(l:arch)
    let l:arch = input('请输入 CUDA 架构（例如 sm_86，留空取消）: ')
    if l:arch !~# '^sm_[0-9]\+$'
      echo '已取消 CUDA 编译'
      return
    endif
  endif

  let l:src = expand('%:p')
  let l:exe = expand('%:p:r')
  let l:cmd = 'nvcc -std=c++17 -arch=' . l:arch . ' '
        \ . shellescape(l:src) . ' -o ' . shellescape(l:exe)
  execute 'AsyncRun ' . l:cmd
endfunction

" 优先读取驱动报告的 compute capability，避免维护显卡型号表
function! DetectGpuArch()
  if !executable('nvidia-smi')
    return ''
  endif

  let l:caps = systemlist('nvidia-smi --query-gpu=compute_cap --format=csv,noheader 2>/dev/null')
  if !v:shell_error && !empty(l:caps)
    let l:cap = matchstr(l:caps[0], '\d\+\.\d\+')
    if !empty(l:cap)
      return 'sm_' . substitute(l:cap, '\.', '', '')
    endif
  endif

  " 兼容无法查询 compute_cap 的旧驱动，只作为兜底
  let l:names = systemlist('nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null')
  if v:shell_error || empty(l:names)
    return ''
  endif
  let l:name = l:names[0]

  if l:name =~? 'RTX 40[6-9]0\|RTX 4090'
    return 'sm_89'
  elseif l:name =~? 'RTX 3090\|RTX 3080\|RTX 3070\|RTX 3060\|A10\|A30'
    return 'sm_86'
  elseif l:name =~? 'RTX 2080\|RTX 2070\|RTX 2060\|Tesla T4'
    return 'sm_75'
  elseif l:name =~? 'A100'
    return 'sm_80'
  elseif l:name =~? 'H100\|H800'
    return 'sm_90'
  endif

  return ''
endfunction

function! CheckAndListCondaEnvs()
  let g:has_conda = executable('conda')
  let g:conda_envs = []

  if !g:has_conda
    echo '未找到 conda，将使用系统 python3'
    return
  endif

  for l:line in systemlist('conda env list 2>/dev/null')
    if l:line =~# '^\S\+\s\+/' && l:line !~# '^#'
      let l:name = matchstr(l:line, '^\S\+')
      if index(g:conda_envs, l:name) < 0
        call add(g:conda_envs, l:name)
      endif
    endif
  endfor
endfunction

function! SelectCondaEnv()
  if !get(g:, 'has_conda', 0) || empty(g:conda_envs)
    return 'python3'
  endif

  let l:idx = inputlist(['选择 Conda 环境:'] + g:conda_envs)
  if l:idx > 0 && l:idx <= len(g:conda_envs)
    return 'conda run --no-capture-output -n ' . shellescape(g:conda_envs[l:idx - 1]) . ' python3'
  endif
  return 'python3'
endfunction

function! RunPython()
  call CheckAndListCondaEnvs()
  let l:python_cmd = SelectCondaEnv()
  execute 'AsyncRun ' . l:python_cmd . ' ' . shellescape(expand('%:p'))
endfunction

function! RunShell()
  execute 'AsyncRun sh ' . shellescape(expand('%:p'))
endfunction

function! RunJava()
  let l:src_dir = expand('%:p:h')
  let l:class_name = expand('%:t:r')
  execute 'AsyncRun java -cp ' . shellescape(l:src_dir) . ' ' . shellescape(l:class_name)
endfunction

function! OpenInBrowser()
  let l:file = expand('%:p')
  if g:is_mac
    execute 'silent !open ' . shellescape(l:file)
  elseif g:is_windows
    execute 'silent !start "" ' . shellescape(l:file)
  elseif executable('firefox')
    execute 'silent !firefox ' . shellescape(l:file) . ' &'
  elseif executable('xdg-open')
    execute 'silent !xdg-open ' . shellescape(l:file) . ' &'
  else
    echo '未找到可用浏览器'
  endif
endfunction

function! RunMarkdownPreview()
  if exists(':MarkdownPreview') == 2
    MarkdownPreview
  elseif exists(':Glowsplit') == 2
    Glowsplit
  else
    echo '未找到 Markdown 预览命令'
  endif
endfunction

function! RunLatexPreview()
  if exists(':LLPStartPreview') == 2
    LLPStartPreview
  else
    call AsyncRunLatex()
  endif
endfunction
