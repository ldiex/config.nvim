set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab

let mapleader = "\<Space>"
nnoremap <leader>mm :call MdToLatex()<CR>

function! MdToLatex()
  let l:start_pos = getpos('.')
  
  %s/^# \(.*\)$/\\section{\1}/ge
  %s/^## \(.*\)$/\\subsection{\1}/ge
  %s/^### \(.*\)$/\\subsubsection{\1}/ge
  
  %s/\*\*\(.\{-}\)\*\*/\\textbf{\1}/ge
  
  %s/\$\$\n\s*\\begin{aligned}\s*/\\begin{align}/ge
  %s/\s*\\end{aligned}\n\s*\$\$/\\end{align}/ge
  call setpos('.', l:start_pos)

  let line_number = line('.')
  let l:count = 0

  while line_number <= line('$')
    let line = getline(line_number)
    if line =~ '$$'
      let l:count += 1
      if l:count % 2 == 1
        execute line_number . 's/\$\$/\\begin{equation}/'
      else
        execute line_number . 's/\$\$/\\end{equation}/'
      endif
    endif
    let line_number += 1
  endwhile
endfunction

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
