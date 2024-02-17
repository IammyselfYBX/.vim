let s:python_until_eof = "python3 << EOF"
if !has("python3")
  let s:python_until_eof = "python << EOF"
  if !has("python")
    echohl WarningMsg
    echom  "Ici requires py >= 2.7 or py3"
    echohl None
    unlet s:python_until_eof
    finish
  endif
endif

function! Ici(word)
  exec s:python_until_eof
import vim
try:
    from urllib.request import urlopen
except ImportError:
    from urllib2 import urlopen
from xml.dom import minidom

WORD = vim.eval("a:word")
KEY = 'E0F0D336AF47D3797C68372A869BDBC5'
URL = 'http://dict-co.iciba.com/api/dictionary.php'


def get_response(word):
    return urlopen(URL + '?key=' + KEY + '&w=' + word)


def read_xml(xml):
    dom = minidom.parse(xml)
    return dom.documentElement


def show(node):
    if not node.hasChildNodes():
        if node.nodeType == node.TEXT_NODE and node.data != '\n':
            tag_name = node.parentNode.tagName
            content = node.data.replace('\n', '')
            if tag_name == 'ps':
                print(content, end=" ")
                
            elif tag_name == 'orig':
                print(content)
            elif tag_name == 'trans':
                print(content)
                print('---------------------------')
            elif tag_name == 'pos':
                print(content, end=" ")
            elif tag_name == 'acceptation':
                print(content)
                print('==========================')
    else:
        for e in node.childNodes:
            show(e)


def main():
    root = read_xml(get_response(WORD))
    show(root)

if __name__ == '__main__':
    main()
EOF
endfunction


function! IciFrom()
let word = expand("<cword>")
call Ici(word)
endfunction


command! -nargs=1 Ici :call Ici(<q-args>)
command! -nargs=0 IciFrom :call IciFrom()
