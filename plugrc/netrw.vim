" ========= NetRw

" Don't keep folder browsing history
let g:netrw_dirhistmax = 0
" Medium speed browsing is fast enough
let g:netrw_fastbrowse = 1
" Suppress the banner
let g:netrw_banner = 0
" 25% width reservation by default
let g:netrw_winsize = 75
" Preserve file times for scp operations
let g:netrw_scp_cmd = 'scp -pq'
" Reuse previous window where possible
let g:netrw_browse_split = 4
" Don't list ./ and ../
let g:netrw_list_hide='^\.\/$,^\.\.\/$'
" Don't show ssh banner
let g:netrw_ssh_browse_reject = '^.*$'
" Key rebinding
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
    " Ctrl-l is also used for clearing searches
    nnoremap <buffer> <silent> <C-l> :nohlsearch <bar> set nolist<Enter><C-l>
endfunction

