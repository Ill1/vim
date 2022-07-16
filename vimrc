" :help option-list # Shows what options are available and what they do
" :options          # Displays and changes options on the fly

" ========= General options (How Vim works, what it does)
set nocompatible
" Read a file automatically if it was changed outside of vim
set autoread
" Backspace carries on until the beginning of the file
set backspace=indent,eol,start
" When displaying auto-complete options:
"   - show a menu of available options, even if there's only 1
"   - don't insert anything, don't select anything
"   - don't show a preview of selectable options
set completeopt=menuone,noinsert,noselect
" Confirm before losing changes, switch buffers without saving
set confirm hidden
" New panes open below, vertical panes to the right
" Diff panes split vertically by default
set splitbelow splitright diffopt+=vertical
" Show 3 lines above and below cursor, show as much as possible of the lastline
set scrolloff=3 display+=truncate
" Use 8-bit Unicode
set encoding=utf-8 | let &termencoding=&encoding
" Disable auditory bell, enable visual flash
set noerrorbells visualbell
" Shift in 4s, indent in 4s, tab represents 4 but don't use them
set expandtab shiftwidth=4 tabstop=4 " smarttab
" Don't change the EOF placement
set noendofline nofixendofline
" When showing folds, show 2 levels before folding
set foldlevel=2
" When inserting text:
"   - Don't auto-wrap text using text width
"   - Insert comment leader on Enter in Insert mode
"   - Don't insert comment leader on O or o in Normal mode
"   - format with gq
"   - long lines aren't formatted after inserting text
"   - remove a comment delimiter when joining lines
set formatoptions=cqlj textwidth=80
" Search as and when the search is entered, highlight as you go, ignore case
set hlsearch incsearch ignorecase
" Don't break words across lines, wrap text by default
set linebreak wrap
" Modelines considered harmful (CVE-2002–1377, CVE-2016–1248, CVE-2019–12735)
set nomodeline
" Speaking of, pipe instead of using temporary files when possible
set noshelltemp
" Keep cursor column on vertical movements
set nostartofline
" Highlight matching braces
set showmatch
" Hwat
set shortmess=filnxtToO
" Jump to existing buffers first when switching
set switchbuf=useopen,split,usetab
" Write swap and perform cursorhold actions after 2 seconds idling
set updatetime=2000
" Enhance command-line completion, fill till the longest common string
set wildmenu wildmode=list:longest
" Ignore the follow files/folders when expanding globpaths
let wildignorestring = '*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/dist/*,*/packages/*,*/.vs/*,*/node_modules/*'
let &wildignore = has('win32') ? substitute(wildignorestring, '\/', '\\\\', 'g') : wildignorestring


" ========= History-size, session & undo options
" Keep a large history of old commands
set history=1500
" Specify session file contents
set sessionoptions=buffers,folds,help,options,tabpages,winsize,sesdir,localoptions,slash
" Persist undo over Vim sessions
" (This may generate sensitive undofiles for undo operations on sensitive files)
set undofile 


" ========= Misc. Vim generated files and persistent folders
" Create and allocate folder for Vim's optional & persistent state
let s:varDir = expand(resolve(expand('<script>:h')) . '/var')

" Move backup, swap, viminfo and undo files into s:varDir
if !exists("*mkdir")
    echom "Backup, Swap, VimInfo and Undo placement defaulted."
else
    function! GetOrAddDir(folder)
        let l:folder = expand(a:folder)
        if !isdirectory(l:folder) | call mkdir(l:folder, "p") | endif
        return isdirectory(l:folder) ? l:folder : ''
    endfunction
    " Set the backup, swap, undo, viminfo & ctrlPCache directories
    let &backupdir = GetOrAddDir(s:varDir . "/backup")
    let &directory = GetOrAddDir(s:varDir . "/swap")
    let &undodir = GetOrAddDir(s:varDir . "/undo")
    " Store viminfo file in s:varDir directory
    let &viminfo .= ",n" . expand(s:varDir . "/.viminfo")
    " Set ctrlP caching folder
    let g:ctrlp_cache_dir = GetOrAddDir(s:varDir . '/ctrlpCache/' . v:servername)
endif


" ========= Plugins (Note the .gitmodule file)
" Builtin: jump-to (%) operations for html tags
packadd! matchit
runtime plugrc/netrw.vim
runtime plugrc/gruvbox.vim
runtime plugrc/targets.vim
runtime plugrc/ctrlP.vim
runtime plugrc/spelunker.vim
runtime plugrc/omnisharp.vim
runtime plugrc/asyncomplete.vim
runtime plugrc/ale.vim
runtime plugrc/lightline.vim
filetype plugin indent on
syntax on


" ========= UI (How Vim looks)
" Show the status line, cursors line and column, echo normal-mode commands
set laststatus=2 ruler showcmd
" Adjust list-mode visualization
set listchars=nbsp:¬,tab:\|\ ,extends:»,precedes:«,trail:•
" When using Gvim
if has("gui_win32")
    " Pass alt-key commands back to the windowing system
    set winaltkeys=yes
    " Including Alt-Space
    nnoremap <M-Space> :simalt~<CR>
    " Maximize on startup
    autocmd GUIEnter * simalt ~x
    " Remove the chrome
    set guioptions-=gmrLtT
    " Adobe's own Source Code Pro
    set guifont=Source_Code_Pro:h13:cANSI:qCLEARTYPE
elseif has("win32")
    " 0 -> blinking block not working in wsl
    " 1 -> blinking block
    " 2 -> solid block
    " 3 -> blinking underscore
    " 4 -> solid underscore
    " 5 -> blinking vertical bar
    " 6 -> solid vertical bar

    " normal mode
    let &t_EI .= "\<Esc>[1 q"
    " insert mode
    let &t_SI .= "\<Esc>[5 q"
    " replace mode (currently causes a tab jump?)
    let &t_SR .= "\<Esc>[4 q"
endif


" ========= Keymapping (use :map to list all)
" Define leader key
let mapleader = ","
" Browse from the current file's location
nnoremap <leader>. :Explore<CR>
" Focus on current window
nnoremap <leader>f <C-w><C-o>
" From normal mode, `q/` searches the search history, `q:` for cmd history then
nmap q; q:
" No, don't write all and force quit
nmap ZZ <nop>
" Insert lines above and below, return to position in normal mode
nmap <leader>j mzo<Esc>'z
nmap <leader>J mzO<Esc>'z
" Normally ; jumps to next t or f command matches, : enters normal mode.
" Swap the colon and the semi-colon
nnoremap : ;
nnoremap ; :
" Go to mark vs go to start of line that the mark is on
" Swap the tick and the back-tick
nnoremap ' `
nnoremap ` '
" Ctrl-S saves
nnoremap <C-s> :update<Enter>
" Clear search result highlighting and deactivate list-view 
nnoremap <silent> <C-l> :nohlsearch <bar> set nolist<Enter><C-l>
" Search for mentions of the current file name through the git repo files
" Don't jump to first instance and redraw
nnoremap <silent> <F6> :silent execute 'Ggrep! ' . expand("%:t:r") <CR> <C-l>

" Preview window move up and down options using j and k instead of N and P
inoremap <expr> <c-j> pumvisible() ? "\<lt>c-n>" : "\<lt>c-j>"
inoremap <expr> <c-k> pumvisible() ? "\<lt>c-p>" : "\<lt>c-k>"
" Choose option highlighted in preview using enter instead of Ctrl-Y(es)
inoremap <CR> <C-R>=pumvisible() ? "\<lt>C-Y>" : "\<lt>CR>"<CR>
inoremap <C-space> <C-R>=pumvisible() ? "\<lt>C-Y>" : "\<lt>C-space>"<CR>


" ========= Autocommands
augroup vimrc
    autocmd!
    autocmd BufReadPost * call JumpToLastKnownCursorPosition()

    autocmd FileType json nnoremap <silent> <F11> :%!jq <CR>
    autocmd FileType cs nnoremap <buffer> <F11> :OmniSharpCodeFormat<CR>
    autocmd FileType javascript setlocal foldmethod=syntax

    function! JumpToLastKnownCursorPosition()
        " search for *last-position-jump*
        " If you'd be at the top of the file anyway,
        " check if vim remembers the cursor last position
        " and if that last cursor position doesn't go beyond the file
        if line(".") == 1 && line("'\"") > 1 && line("'\"") <= line("$") 
            " just to that last known cursor position
            execute "normal! g`\""
        endif
    endfunction
augroup END

" Set and restore cursor under windows
if &term =~ 'win32'
    augroup windows_term
        autocmd!
        autocmd VimEnter * silent !echo -ne "\e[1 q" 
        autocmd VimLeave * silent !echo -ne "\e[3 q" 
    augroup END
endif