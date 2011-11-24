function! Toggle_task_status()
    let line = getline('.')
    if match(line, '^\(\s*\)-') == 0
        let line = substitute(line, '^\(\s*\)-', '\1✓', '')
    else
        let line = substitute(line, '^\(\s*\)✓', '\1-', '')
    endif
    call setline('.', line)
endfunction

noremap <silent> <buffer> <space> :call Toggle_task_status()\|:w<CR>
