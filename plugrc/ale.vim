" ========= Ale

let g:ale_cache_executable_check_failures = 1
let g:ale_linters = { 
            \ 'cs': ['OmniSharp'],
            \ 'json': ['eslint'] 
            \ }
let g:ale_fixers = {
            \   'javascript': ['prettier', 'eslint'],
            \   'css': ['prettier'],
            \   'jsx': ['eslint', 'prettier'],
            \   'tsx': ['eslint', 'prettier']
            \ }

let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'

let g:ale_jsx_prettier_options = '--jsx-ignore-line-break'

let s:clang_triple = 'target=x86_64-pc-windows-gnu'
let g:ale_cpp_cc_options = '-std=c++20 -Wall --' . s:clang_triple
let g:ale_cpp_clangcheck_options = '--extra-arg=-std=c++20 --extra-arg=--' . s:clang_triple
let g:ale_cpp_clangtidy_options = '--std=c++20 -Wall --' . s:clang_triple
let g:ale_cpp_clangd_options = s:clang_triple
let g:ale_objc_clang_options = ' -' . s:clang_triple

" move between ale warnings quickly
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
