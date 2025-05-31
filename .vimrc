set relativenumber
set tabstop=4

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

