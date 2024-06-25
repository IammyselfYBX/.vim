let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_linters = {
\   'c': ['gcc'],
\   'cpp': ['g++'],
\   'cuda': ['nvcc'],
\}
let g:ale_cuda_nvcc_executable = 'nvcc'
let g:ale_cuda_nvcc_options = '-arch=all -std=c++11 -ccbin=gcc'

