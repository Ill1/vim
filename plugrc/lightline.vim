" ========= Lightline

" Minimalist status line: 'itchyny/lightline.vim'
" Show the Git branch: 'itchyny/vim-gitbranch'
" Ale + Lightline: 'maximbaz/lightline-ale'

let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'fileformat', 'fileencoding', 'filetype', 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'gitbranch#name',
            \   'linter_checking': 'lightline#ale#checking',
            \   'linter_warnings': 'lightline#ale#warnings',
            \   'linter_errors': 'lightline#ale#errors',
            \   'linter_ok': 'lightline#ale#ok'
            \ },
            \ 'component_type': {
            \   'linter_checking': 'left',
            \     'linter_warnings': 'warning',
            \     'linter_errors': 'error',
            \     'linter_ok': 'left'
            \ }
            \ }

