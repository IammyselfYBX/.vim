let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

" ALE linters 配置
let g:ale_linters = {
\   'c': ['ccls', 'gcc' ],
\   'cpp': ['ccls'],
\   'cuda': ['nvcc'],
\}

" 默认编译选项
" let g:ale_c_gcc_options = '-std=c17 -Wall'
" let g:ale_cpp_gcc_options = '-std=c++17 -Wall'

" ccls 配置
"" C 的ccls支持
let g:ale_c_ccls_executable = 'ccls'
let g:ale_c_ccls_init_options = {
\   'cache': {
\     'directory': '.ccls-cache'
\   },
\   'completion': {
\     'duplicateOptional': v:false
\   },
\   'diagnostics': {
\     'onOpen': 1,
\     'onSave': 1
\   }
\}
" GCC 编译选项（备用 linter）
let g:ale_c_gcc_options = '-std=c17 -Wall'

"" C++ 的ccls支持
let g:ale_cpp_ccls_executable = 'ccls'
let g:ale_cpp_ccls_init_options = {
\   'cache': {
\     'directory': '.ccls-cache'
\   },
\   'completion': {
\     'duplicateOptional': v:false
\   },
\   'diagnostics': {
\     'onOpen': 1,
\     'onSave': 1
\   }
\}

" CUDA 配置
let g:ale_cuda_nvcc_executable = 'nvcc'
let g:ale_cuda_nvcc_options = '-arch=all -std=c++11 -ccbin=gcc'

" ALE 行为设置
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1

" 错误信息格式
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

