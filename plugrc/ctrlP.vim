" ========= CtrlP

" Cache file entries over a vim-session
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 1

" Backspace exits CtrlP prompt
let g:ctrlp_brief_prompt = 1

" Show match-prompt at the bottom of the screen
" ordering from bottom to top
" at least 1 line, at most 11
" with at most 49 results in the window
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:11,results:49'

" Define folder names to exclude when using user specified retrieval command
" findstr command seperates search terms by space, default dir excludes hidden
" folders like .git
let excludeExpr = 'lib$ exe$ dll$ obj$ \\.git\\*'
" In version controlled folders, provide files tracked by version control
" In repos folder, just folders
let g:ctrlp_user_command = {
            \ 'types': {
            \ 1: ['.git', 'git ls-files -co --exclude-standard']
            \ },
            \ 'fallback': has('win32')
            \ ? 'dir %s /-n /b /s /a-d | findstr /V /I /R "'.excludeExpr.'"'
            \ : 'find %s -type f | grep -v "'.excludeExpr .'"'
            \ }

" Don't Glob over the following
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

let g:ctrlp_extensions = ['dir']
