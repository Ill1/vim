" ========= Asyncomplete

" Don't override completeopt
let g:asyncomplete_auto_completeopt = 0

inoremap <expr> <C-y> pumvisible() ? asyncomplete#close_popup() : "\<C-y>"
inoremap <expr> <C-e> pumvisible() ? asyncomplete#cancel_popup() : "\<C-e>"
