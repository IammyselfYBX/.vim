let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_sign_info = 'I'

" C/C++/CUDA 的诊断由 COC + clangd 统一负责。
" 不在 ALE 中重复启动 ccls/clangd，避免同一个文件被两套 LSP 重复分析。
let g:ale_linters = {
      \ 'c': [],
      \ 'cpp': [],
      \ 'cuda': [],
      \ }

" 如需恢复 ALE 独立编译检查，可改成：
" 'c': ['cc'], 'cpp': ['cc'], 'cuda': ['nvcc']

" ALE 行为设置
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1

" 错误信息格式
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
