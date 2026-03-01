set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab

let mapleader = "\<Space>"

function! ReplaceChinesePunctuation()
    " Get the content of the current line
    let l:current_line = getline('.')

    let l:punct_map = {
        \ '，': ', ',
        \ '。': '. ',
        \ '？': '? ',
        \ '！': '! ',
        \ '；': '; ',
        \ '：': ': ',
        \ '（': ' (',
        \ '）': ') ',
        \ '【': ' [',
        \ '】': '] ',
        \ '《': ' <',
        \ '》': '> ',
        \ '“': ' "',
        \ '”': '" ',
        \ '‘': " '",
        \ '’': "' ",
        \ '、': ', ',
        \ '…': '...',
        \ '·': '.',
        \ '－': '-',
        \ '—': '---',
        \ '　': ' '
        \ }

    " Create a regex pattern by joining all keys (Chinese characters) with '|'
    " We need to escape special regex characters if any of the keys were special,
    " but for these Chinese punctuation marks, they are literal.
    let l:pattern_parts = []
    for l:char in keys(l:punct_map)
        " Escape characters that might have special meaning in a regex pattern
        " For this specific set, most are literal, but it's good practice.
        call add(l:pattern_parts, escape(l:char, '\.*$^[]'))
    endfor
    let l:regex_pattern = '\%(' . join(l:pattern_parts, '\|') . '\)'

    " Use a lambda function in substitute() to look up the replacement
    " :help submatch() gives the matched string
    let l:current_line = substitute(l:current_line, l:regex_pattern, '\=l:punct_map[submatch(0)]', 'g')

    " Set the current line back with the modified content
    call setline('.', l:current_line)
endfunction

function! ConvertToUnix()
    " 将当前缓冲区的换行格式设置为 unix (LF)
    setlocal fileformat=unix
    " 移除可能残留在行尾的控制字符 ^M
    silent! %s/\r$//g
    echo "Converted to Linux (LF) format."
endfunction
