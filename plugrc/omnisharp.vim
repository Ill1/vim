" ========= Omnisharp
" C# Linting, Autocomplete, Navigation

if isdirectory($USERPROFILE) | let g:OmniSharp_server_path = 'omnisharp.exe' | endif
" Talk directly to a server using io
let g:OmniSharp_server_stdio = 1
" Send a message when Omnisharp's done loading the solution/project file
let g:OmniSharp_server_display_loading = 1
" Extend the initial loading timeout to wait for larger projects
let g:OmniSharp_server_loading_timeout = 210
" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 40
" Integrate Omnisharp and Ctrl-P (should detect automatically)
let g:OmniSharp_selector_ui 	= 'ctrlp' 
" Highlight types on BufEnter and InsertLeave
let g:OmniSharp_highlight_types = 2
" Retrieve metadata for compiled types
let g:OmniSharp_lookup_metadata = 1
" Fetch full Documentation for types
let g:omnicomplete_fetch_full_documentation = 0
" Leave the quickfix window alone
let g:OmniSharp_open_quickfix = 0
" Use dotnet6.0
let g:OmniSharp_server_use_net6 = 1
" Don't do it.
let g:OmniSharp_loglevel = 'none'

" Experimental: load types, load symbols - coupled with omnisharp mod to load
" symbols in the background (search for symbols.vim)
" autocmd User OmniSharpProjectUpdated,OmniSharpReady OmniSharpFindSymbol

function! OSCountCodeActions() abort
  if bufname('%') ==# '' || OmniSharp#FugitiveCheck() | return | endif
  if !OmniSharp#IsServerRunning() | return | endif
  let opts = {
              \ 'CallbackCount': function('s:CBReturnCount'),
              \ 'CallbackCleanup': {-> execute('sign unplace 99')}
              \}
  call OmniSharp#CountCodeActions(opts)
endfunction

function! s:CBReturnCount(count) abort
  if a:count
      let l = getpos('.')[1]
      let f = expand('%:p')
      " setlocal signcolumn=yes
      execute ':sign place 99 line='.l.' name=OmniSharpCodeActions file='.f
  endif
endfunction

if has("autocmd")
    augroup omnisharpAu
        autocmd!
        " Go look for code actions when the cursor hovers
        " Src: https://github.com/OmniSharp/omnisharp-vim/wiki/Code-Actions-Available-flag
        "sign define OmniSharpCodeActions text=💡
        "autocmd CursorHold *.cs call OSCountCodeActions()

        " Show type information automatically when the cursor stops moving
        "autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
        " The following commands are contextual, based on the cursor position.
        autocmd FileType cs nnoremap <buffer> <F12> :OmniSharpGotoDefinition<CR>
        autocmd FileType cs nnoremap <buffer> <C-F12> :OmniSharpFindImplementations<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>d :OmniSharpGotoDefinition<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>D :OmniSharpFindImplementations<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>s :OmniSharpFindSymbol<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>u :OmniSharpFindUsages<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>a :OmniSharpGetCodeActions<CR>
        " git apply b2/var/scripts/omnisharp-vim-symbols-loaded.patch
        autocmd FileType cs nnoremap <buffer> <Leader>t :call ctrlp#init(ctrlp#OmniSharp#findsymbols#id())<CR>
    augroup END

    augroup cSharpAu
        " Use :mak
        autocmd!
        autocmd FileType cs set makeprg=msbuild\ -t:Build\ -p:Configuration=Debug\ -p:GenerateFullPaths=true
        autocmd FileType cs set errorformat=\ %#%f(%l\\\,%c):\ %m
    augroup END

endif

