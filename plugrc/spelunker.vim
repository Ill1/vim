" ========= Spelunker
" Spell check (+camelCase)

" Check buffer on cursorhold time (rather than file, on read and write)
let g:spelunker_check_type = 2
" Disable default autogroup. (default: 0)
let g:spelunker_disable_auto_group = 1

augroup spelunker
    autocmd!
    autocmd CursorHold *.tex,*.cs,*.cpp,*.c++,*.h,*.hpp,*.ps1,*.vim,*.js,*.jsx,*.json,*.md,gitcommit call spelunker#check_displayed_words()
augroup END

