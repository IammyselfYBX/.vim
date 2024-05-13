"---------------------------------------------------
" gdb调试
"---------------------------------------------------
" <F8> 调试c/c++
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    if &filetype == 'c'
            "exec "!gcc % -g -o %<"
            "exec "!gdb -q ./%<"
            :AsyncRun gcc % -g -o %< && ./%<
            :call asyncrun#quickfix_toggle(6)
            ":term gdb -q ./%<
            :packadd termdebug
            :Termdebug ./%<
    elseif &filetype == 'cpp'
            "exec "!g++ % -g -o %<"
            "exec "!gdb -q ./%<"
            :AsyncRun g++ % -g -o %< && ./%<
            :call asyncrun#quickfix_toggle(6)
            ":term gdb -q ./%<
            :packadd termdebug
            :Termdebug ./%<
    elseif &filetype =='sh'
            "exec "!bash -x %"
            :term bash -x %
    elseif &filetype == 'python'
            "exec "!python %"
            :term python3 -m pdb %
    endif
endfunc