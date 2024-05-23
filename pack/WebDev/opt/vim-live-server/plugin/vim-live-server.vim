" vim-live-server.vim

" A live web server for Vim
" By Wolandark
" https://github.com/wolandark/vim-live-server

" Check if a command exists
function! CommandExists(cmd)
    return !empty(system('command -v ' . a:cmd))
endfunction

" Install a command using npm
function! InstallCommand(cmd)
    let install_cmd = "sudo npm install -g " . a:cmd
    call system(install_cmd)
    echo a:cmd . " installed."
endfunction

"Browser-Sync
function! StartBrowserSync()
    if !CommandExists('browser-sync')
        call InstallCommand('browser-sync')
    endif
    let cmd = "browser-sync start --no-notify --server --files *.html, *.css, *.js &"
    call system(cmd)
    echo "BrowserSync started in the background."
endfunction

function! StartBrowserSyncOnPort(port)
    if !CommandExists('browser-sync')
        call InstallCommand('browser-sync')
    endif
    let port_num = a:port + 0  " Convert a:port to a number
    let cmd = "browser-sync start --no-notify --server --cwd=" . getcwd() . " --port=" . port_num . " --files \"*.html, *.css, *.js\" &"
    call system(cmd)
    echo "BrowserSync started in the background on port " . port_num . "."
endfunction

function! KillBrowserSync()
    let port = systemlist("pgrep -f 'browser-sync'")[0]
    if empty(port)
        echo "No BrowserSync server found on port 3000."
    else
        let cmd = "kill " . port
        call system(cmd)
        echo "BrowserSync server on port 3000 terminated."
    endif
endfunction

function! KillBrowserSyncOnPort(port)
    let cmd = "pgrep -f 'browser-sync.*--port=" . a:port . "' | xargs -r kill"
    call system(cmd)
    echo "BrowserSync server on port " . a:port . " terminated."
endfunction

function! KillAllBrowserSyncInstances()
    let cmd = "pkill -f 'browser-sync'"
    call system(cmd)
endfunction

augroup BrowserSyncKill
    autocmd!
    autocmd VimLeave * call KillAllBrowserSyncInstances()
augroup END

" Live-Server
function! StartLiveServer()
    if !CommandExists('live-server')
        call InstallCommand('live-server')
    endif
    let cmd = "live-server &"
    call system(cmd)
    echo "Live server started in the background."
endfunction

function! StartLiveServerOnPort(port)
    if !CommandExists('live-server')
        call InstallCommand('live-server')
    endif
    let port_num = a:port + 0  " Convert a:port to a number
    let cmd = "live-server --port=" . port_num . "&"
    call system(cmd)
    echo "Live Server started in the background on port " . port_num . "."
endfunction

function! KillLiveServer()
    let port = systemlist("pgrep -f 'live-server'")[0]
    if empty(port)
        echo "No Live Server found on port 8080."
    else
        let cmd = "kill " . port
        call system(cmd)
        echo "Live Server on port 8080 terminated."
    endif
endfunction

function! KillLiveServerOnPort(port)
    let cmd = "pgrep -f 'live-server.*--port=" . a:port . "' | xargs -r kill"
    call system(cmd)
    echo "Live Server on port " . a:port . " terminated."
endfunction

function! KillAllLiveServerInstances()
    let cmd = "pkill -f 'live-server'"
    call system(cmd)
endfunction

augroup LiveServerKill
    autocmd!
    autocmd VimLeave * call KillAllLiveServerInstances()
augroup END

" Call Commands
command! StartBrowserSync call StartBrowserSync()
command! StartLiveServer call StartLiveServer()
command! -nargs=1 StartBrowserSyncOnPort call StartBrowserSyncOnPort(<f-args>)
command! -nargs=1 StartLiveServerOnPort call StartLiveServerOnPort(<f-args>)
command! KillBrowserSync call KillBrowserSync()
command! KillLiveServer call KillLiveServer()
command! -nargs=1 KillBrowserSyncOnPort call KillBrowserSyncOnPort(<f-args>)
command! -nargs=1 KillLiveServerOnPort call KillLiveServerOnPort(<f-args>)

