" vim-live-server.vim

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

" Browser-Sync
function! StartBrowserSync()
    if !CommandExists('browser-sync')
        call InstallCommand('browser-sync')
    endif
    if exists('g:BrowserSyncPort') && !empty(g:BrowserSyncPort)
        call StartBrowserSyncOnPort(g:BrowserSyncPort)
    else
        let cmd = "browser-sync start --no-notify --server --files *.html, *.css, *.js &"
        call system(cmd)
        let g:last_server = 'browser-sync'
        echo "BrowserSync started in the background."
    endif
endfunction

function! StartBrowserSyncOnPort(port)
    if !CommandExists('browser-sync')
        call InstallCommand('browser-sync')
    endif
    let port_num = a:port + 0  " Convert a:port to a number
    let cmd = "browser-sync start --no-notify --server --cwd=" . getcwd() . " --port=" . port_num . " --files \"*.html, *.css, *.js\" &"
    call system(cmd)
    let g:last_server = 'browser-sync'
    echo "BrowserSync started in the background on port " . port_num . "."
endfunction

function! KillBrowserSync()
    let port = systemlist("pgrep -f 'browser-sync'")[0]
    if empty(port)
        echo "No BrowserSync server found on port 3000."
    else
        let cmd = "kill " . port
        call system(cmd)
        if exists('g:BrowserSyncPort') && !empty(g:BrowserSyncPort)
            echo "BrowserSync server on port " . g:BrowserSyncPort . " terminated."
        else
            echo "BrowserSync server on port 3000 terminated."
        endif
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
    if exists('g:LiveServerPort') && !empty(g:LiveServerPort)
        call StartLiveServerOnPort(g:LiveServerPort)
    else
        let cmd = "live-server &"
        call system(cmd)
        let g:last_server = 'live-server'
        echo "Live server started in the background."
    endif
endfunction

function! StartLiveServerOnPort(port)
    if !CommandExists('live-server')
        call InstallCommand('live-server')
    endif
    let port_num = a:port + 0  " Convert a:port to a number
    let cmd = "live-server --port=" . port_num . "&"
    call system(cmd)
    let g:last_server = 'live-server'
    echo "Live Server started in the background on port " . port_num . "."
endfunction

function! KillLiveServer()
    let port = systemlist("pgrep -f 'live-server'")[0]
    if empty(port)
        echo "No Live Server found on port 8080."
    else
        let cmd = "kill " . port
        call system(cmd)
        if exists('g:LiveServerPort') && !empty(g:LiveServerPort)
            echo "Live Server on port " . g:LiveServerPort . " terminated."
        else
            echo "Live Server on port 8080 terminated."
        endif
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

" User selection for server to start
function! ChooseServer()
    echo "Choose server to start:"
    echo "1. live-server"
    echo "2. browser-sync"
    let choice = input("Enter your choice: ")
    if choice == '1'
        call StartLiveServer()
    elseif choice == '2'
        call StartBrowserSync()
    else
        echo "Invalid choice"
    endif
endfunction

" Toggle server based on last choice
function! ToggleServer()
    if !exists('g:server_running') || !g:server_running
        call ChooseServer()
        let g:server_running = 1
    else
        call KillServer()
        let g:server_running = 0
    endif
endfunction

" Kill server based on last choice
function! KillServer()
    if exists('g:last_server')
        if g:last_server == 'live-server'
            call KillLiveServer()
        elseif g:last_server == 'browser-sync'
            call KillBrowserSync()
        else
            echo "Unknown server type"
        endif
    else
        echo "No server has been started"
    endif
endfunction

" Call Commands
command! StartBrowserSync call StartBrowserSync()
command! StartLiveServer call StartLiveServer()
command! -nargs=1 StartBrowserSyncOnPort call StartBrowserSyncOnPort(<f-args>)
command! -nargs=1 StartLiveServerOnPort call StartLiveServerOnPort(<f-args>)
command! KillBrowserSync call KillBrowserSync()
command! KillLiveServer call KillLiveServer()
command! -nargs=1 KillBrowserSyncOnPort call KillBrowserSyncOnPort(<f-args>)
command! -nargs=1 KillLiveServerOnPort call KillLiveServerOnPort(<f-args>)
command! LIVEToggle call ToggleServer()

" Key mappings
nnoremap <silent> <F3> :LIVEToggle<CR>

" Set default values for ports (optional)
let g:BrowserSyncPort = '9999'
let g:LiveServerPort = '9998'
let g:server_running = 0

