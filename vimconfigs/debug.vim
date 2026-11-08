" C/C++ 调试
" F8 先同步编译，成功后再启动 Termdebug，避免异步编译与 gdb 竞态
nnoremap <F8> :call Rungdb()<CR>

function! Rungdb()
  if index(['c', 'cpp'], &filetype) < 0
    echo 'F8 目前仅支持 C/C++'
    return
  endif

  let l:src = expand('%:p')
  let l:exe = expand('%:p:r')
  let l:compiler = &filetype ==# 'cpp' ? 'g++' : 'gcc'
  let l:flags = &filetype ==# 'cpp' ? '-g -std=c++17' : '-g -lm'
  let l:cmd = l:compiler . ' ' . l:flags . ' '
        \ . shellescape(l:src) . ' -o ' . shellescape(l:exe)
  let l:output = system(l:cmd)

  if v:shell_error
    echo l:output
    echo '编译失败，未启动调试器'
    return
  endif

  execute 'packadd termdebug'
  execute 'Termdebug ' . fnameescape(l:exe)
endfunction
