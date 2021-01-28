set number " turn on line numbers
syntax on " required to show syntax colors

" highlighting
set hlsearch
set incsearch
 
set formatoptions+=c

" disable arrow keys (vi muscle memory)
noremap <up> :echoerr "Umm, use k instead"<CR>
noremap <down> :echoerr "Umm, use j instead"<CR>
noremap <left> :echoerr "Umm, use h instead"<CR>
noremap <right> :echoerr "Umm, use l instead"<CR>
"inoremap <up> <NOP>
"inoremap <down> <NOP>
"inoremap <left> <NOP>
"inoremap <right> <NOP>


" ALL AVAILABLE DEFAULT COLORSCHEMES
" blue       default    desert     evening    koehler    murphy     peachpuff  shine      torte
" darkblue   delek      elflord    industry   morning    pablo      ron        slate      zellner
" FAVOURITES: koehler, delek, peachpuff, slate, zellner
colorscheme koehler

set noswapfile
