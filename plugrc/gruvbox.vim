" ========= Gruvbox

" Light up the text, not the background
set background=dark

" https://github.com/morhetz/gruvbox/wiki/Terminal-specific
if (empty($TMUX) && has("termguicolors"))
    set termguicolors
endif

let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'hard'

" Remove `++` for nix 
autocmd vimenter * ++nested colorscheme gruvbox
